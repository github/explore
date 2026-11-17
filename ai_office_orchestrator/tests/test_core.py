import os
import unittest

from app.adapters.base import BaseAdapter, MissingCredential
from app.core.circuit_breaker import CircuitBreaker
from app.core.orchestrator import Orchestrator, OrchestratorError
from app.core.task import Task


class Fake(BaseAdapter):
    kinds = ("text",)

    def __init__(self, name, out=None, exc=None, q=0.5):
        self.name, self.out, self.exc = name, out, exc
        self.metrics = dict(quality=q, success=0.5, speed=0.5, cost=0.5)
        self.calls = 0

    def healthy(self):
        return True

    def run(self, task):
        self.calls += 1
        if self.exc:
            raise self.exc
        return self.out


class Tests(unittest.TestCase):
    def test_missing_key(self):
        os.environ.pop("X_KEY", None)
        a = BaseAdapter(); a.env_key = "X_KEY"
        with self.assertRaises(MissingCredential):
            a.credential()

    def test_grok_registered_and_needs_key(self):
        from app.adapters.factory import build_adapters
        g = next(a for a in build_adapters() if a.name == "grok")
        os.environ.pop("XAI_API_KEY", None)
        self.assertFalse(g.healthy())
        with self.assertRaises(MissingCredential):
            g.credential()
        os.environ["XAI_API_KEY"] = "dummy"
        try:
            self.assertTrue(g.healthy())
        finally:
            os.environ.pop("XAI_API_KEY", None)

    def test_consent_token_bound_single_use_and_expiring(self):
        from app.core.consent import ConsentGate
        now = [1000.0]
        gate = ConsentGate(ttl=60, clock=lambda: now[0])
        mk = lambda p: Task("text", p, side_effect=True)
        orch = Orchestrator([Fake("a", out="sent")], consent=gate)

        t = mk("email bob")                      # no token -> refused
        with self.assertRaises(OrchestratorError):
            orch.run(t)

        t.meta["consent_token"] = gate.approve(t)  # approved -> runs once
        self.assertEqual(orch.run(t).output, "sent")
        with self.assertRaises(OrchestratorError):  # replay refused
            orch.run(t)

        other = mk("email eve")                   # token for a different task
        other.meta["consent_token"] = gate.approve(mk("email bob"))
        with self.assertRaises(OrchestratorError):
            orch.run(other)

        late = mk("email amy")                    # expired token
        late.meta["consent_token"] = gate.approve(late)
        now[0] += 61
        with self.assertRaises(OrchestratorError):
            orch.run(late)

    def test_failover(self):
        a, b = Fake("a", exc=RuntimeError("down"), q=0.9), Fake("b", out="hi")
        r = Orchestrator([a, b]).run(Task("text", "x"))
        self.assertEqual(r.provider, "b")

    def test_reject_empty(self):
        a, b = Fake("a", out="  ", q=0.9), Fake("b", out="ok")
        self.assertEqual(Orchestrator([a, b]).run(Task("text", "x")).provider, "b")

    def test_all_fail(self):
        with self.assertRaises(OrchestratorError):
            Orchestrator([Fake("a", out="")]).run(Task("text", "x"))

    def test_circuit(self):
        t = [0.0]
        cb = CircuitBreaker(2, 30, clock=lambda: t[0])
        cb.failure(); cb.failure()
        self.assertFalse(cb.allow())
        t[0] = 31
        self.assertEqual(cb.state, "HALF_OPEN")
        cb.success()
        self.assertEqual(cb.state, "CLOSED")

    def test_side_effect_needs_approval_and_no_failover(self):
        a, b = Fake("a", exc=RuntimeError("t/o"), q=0.9), Fake("b", out="sent")
        o = Orchestrator([a, b])
        with self.assertRaises(OrchestratorError):
            o.run(Task("text", "x", side_effect=True))
        with self.assertRaises(OrchestratorError):
            o.run(Task("text", "x", side_effect=True, approved=True))
        self.assertEqual(b.calls, 0)


if __name__ == "__main__":
    unittest.main()


class TestMetricsPlanner(unittest.TestCase):
    def test_metrics_shift_ranking(self):
        from app.core.metrics import MetricsStore
        m = MetricsStore()
        for _ in range(5):
            m.record("a", "text", False, 1.0)
            m.record("b", "text", True, 0.1)
        o = Orchestrator([Fake("a", out="A", q=0.9), Fake("b", out="B", q=0.5)], metrics=m)
        self.assertEqual(o.ranked(Task("text", "x"))[0], "b")

    def test_classify(self):
        from app.core.planner import classify
        self.assertEqual(classify("fix this bug"), "code")
        self.assertEqual(classify("hello"), "text")


class TestCritic(unittest.TestCase):
    def test_refusal_triggers_failover(self):
        a, b = Fake("a", out="I cannot help with that", q=0.9), Fake("b", out="Answer")
        self.assertEqual(Orchestrator([a, b]).run(Task("text", "x")).provider, "b")

    def test_unsourced_numbers_rejected_when_strict(self):
        a, b = Fake("a", out="Revenue grew 45%", q=0.9), Fake("b", out="Grew 45% (source: report)")
        o = Orchestrator([a, b], strict_facts=True)
        self.assertEqual(o.run(Task("text", "x")).provider, "b")


class TestEnsemble(unittest.TestCase):
    def test_picks_best_valid(self):
        a, b = Fake("a", out="", q=0.9), Fake("b", out="B", q=0.5)
        r = Orchestrator([a, b]).run_ensemble(Task("text", "x"), n=2)
        self.assertEqual(r.provider, "b")
        self.assertEqual(a.calls + b.calls, 2)

    def test_custom_pick(self):
        a, b = Fake("a", out="short", q=0.9), Fake("b", out="much longer answer", q=0.5)
        longest = lambda t, g: max(g, key=lambda k: len(g[k]))
        r = Orchestrator([a, b]).run_ensemble(Task("text", "x"), n=2, pick=longest)
        self.assertEqual(r.provider, "b")

    def test_refuses_side_effects(self):
        with self.assertRaises(OrchestratorError):
            Orchestrator([Fake("a", out="x")]).run_ensemble(
                Task("text", "x", side_effect=True, approved=True))
