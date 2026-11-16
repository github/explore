"""Second-pass review. Uses a reviewer adapter (an LLM) when given; otherwise
falls back to cheap heuristics. Returns (ok, reason)."""
import re

_REFUSAL = re.compile(r"\b(i cannot|i can't|as an ai|unable to assist)\b", re.I)


def heuristic_review(task, output: str):
    text = str(output).strip()
    if _REFUSAL.search(text[:200]):
        return False, "looks like a refusal"
    if len(text) < 3:
        return False, "too short"
    return True, "ok"


def fact_check(output: str):
    """Flag unsupported claims: numbers/URLs present without any source marker.
    Heuristic only; real fact-checking needs a retrieval step."""
    has_claims = bool(re.search(r"\d{2,}|https?://", output))
    has_source = bool(re.search(r"(source|อ้างอิง|ที่มา|https?://)", output, re.I))
    if has_claims and not has_source:
        return False, "numeric claims without source"
    return True, "ok"


def review(task, output, reviewer=None, strict_facts=False):
    if reviewer is not None:
        verdict = str(reviewer.run(type(task)("text",
                f"Reply PASS or FAIL: does this answer the request?\nRequest: {task.prompt}\nAnswer: {output}")))
        if verdict.strip().upper().startswith("FAIL"):
            return False, "reviewer said FAIL"
    ok, why = heuristic_review(task, output)
    if ok and strict_facts:
        ok, why = fact_check(output)
    return ok, why
