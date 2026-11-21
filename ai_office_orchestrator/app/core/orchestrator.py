import time
from concurrent.futures import ThreadPoolExecutor

from .checker import check_output
from .critic import review
from .circuit_breaker import CircuitBreaker
from .scoring import score
from .task import Result


class OrchestratorError(Exception):
    pass


class Orchestrator:
    def __init__(self, adapters, max_attempts=3, breaker_factory=CircuitBreaker, metrics=None,
                 reviewer=None, strict_facts=False, consent=None):
        self.consent = consent
        self.reviewer, self.strict_facts = reviewer, strict_facts
        self.metrics = metrics
        self.adapters = {a.name: a for a in adapters}
        self.breakers = {a.name: breaker_factory() for a in adapters}
        self.max_attempts = max_attempts

    def ranked(self, task):
        scored = []
        for name, a in self.adapters.items():
            if not self.breakers[name].allow():
                continue
            prof = a.profile()
            if self.metrics:
                prof = {**prof, "metrics": {**prof.get("metrics", {}),
                                            **self.metrics.observed(name, task.kind)}}
            s = score(prof, task.kind, a.healthy())
            if s >= 0:
                scored.append((s, name))
        return [n for _, n in sorted(scored, reverse=True)]

    def run(self, task) -> Result:
        # Consent gate: side-effect tasks need approval and never fail over,
        # so a timeout can't cause a duplicate email/publish/event.
        if task.side_effect:
            if self.consent is not None:
                if not self.consent.consume(task, task.meta.get("consent_token")):
                    raise OrchestratorError("side-effect task requires a valid one-time consent token")
            elif not task.approved:
                raise OrchestratorError("side-effect task requires approval")
        attempts = []
        candidates = self.ranked(task)
        if task.side_effect:
            candidates = candidates[:1]
        for name in candidates[: self.max_attempts]:
            t0 = time.monotonic()
            try:
                out = self.adapters[name].run(task)
            except Exception as e:  # noqa: BLE001
                self._rec(name, task, False, t0)
                self.breakers[name].failure()
                attempts.append((name, f"error: {e}"))
                continue
            ok, why = check_output(out)
            if ok:
                ok, why = review(task, out, self.reviewer, self.strict_facts)
            self._rec(name, task, ok, t0)
            if ok:
                self.breakers[name].success()
                attempts.append((name, "ok"))
                return Result(name, out, attempts)
            self.breakers[name].failure()
            attempts.append((name, f"rejected: {why}"))
        raise OrchestratorError(f"no provider produced valid output: {attempts}")

    def _rec(self, name, task, ok, t0):
        if self.metrics:
            self.metrics.record(name, task.kind, ok, time.monotonic() - t0)

    def run_ensemble(self, task, n=2, pick=None):
        """Call the top-n providers in parallel, keep outputs that pass the
        checker and critic, then choose one. `pick(task, {name: output})`
        returns a name; default is the highest-ranked passing provider.
        Side-effect tasks are refused: parallel calls would duplicate them."""
        if task.side_effect:
            raise OrchestratorError("ensemble not allowed for side-effect tasks")
        names = self.ranked(task)[:n]
        if not names:
            raise OrchestratorError("no eligible provider")

        def call(name):
            t0 = time.monotonic()
            try:
                out = self.adapters[name].run(task)
            except Exception as e:  # noqa: BLE001
                self._rec(name, task, False, t0)
                self.breakers[name].failure()
                return name, None, f"error: {e}"
            ok, why = check_output(out)
            if ok:
                ok, why = review(task, out, self.reviewer, self.strict_facts)
            self._rec(name, task, ok, t0)
            (self.breakers[name].success if ok else self.breakers[name].failure)()
            return name, (out if ok else None), why

        with ThreadPoolExecutor(max_workers=len(names)) as ex:
            rows = list(ex.map(call, names))
        attempts = [(n_, "ok" if o is not None else w) for n_, o, w in rows]
        good = {n_: o for n_, o, _ in rows if o is not None}
        if not good:
            raise OrchestratorError(f"no provider produced valid output: {attempts}")
        chosen = pick(task, good) if pick and len(good) > 1 else next(
            n_ for n_ in names if n_ in good)
        return Result(chosen, good[chosen], attempts)
