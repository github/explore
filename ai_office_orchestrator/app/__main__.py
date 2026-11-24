import sys

from app.adapters.factory import build_adapters
from app.core.metrics import MetricsStore
from app.core.orchestrator import Orchestrator
from app.core.planner import plan

if __name__ == "__main__":
    prompt = " ".join(sys.argv[1:]) or "hello"
    orch = Orchestrator(build_adapters(), metrics=MetricsStore("metrics.db"))
    for task in plan(prompt):
        r = orch.run(task)
        print(f"[{r.provider}] {r.output}")
