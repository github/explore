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
