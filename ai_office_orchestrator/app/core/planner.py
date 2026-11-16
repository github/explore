from .task import Task

_KEYWORDS = [("code", ("code", "bug", "function", "script", "โค้ด")),
             ("image", ("image", "picture", "logo", "รูป")),
             ("video", ("video", "วิดีโอ")),
             ("design", ("design", "poster", "canva", "ออกแบบ")),
             ("research", ("research", "compare", "ค้นคว้า", "วิจัย"))]


def classify(prompt: str) -> str:
    p = prompt.lower()
    for kind, words in _KEYWORDS:
        if any(w in p for w in words):
            return kind
    return "text"


def plan(prompt: str) -> list[Task]:
    """Minimal planner: one classified task. Extend to multi-step later."""
    return [Task(classify(prompt), prompt)]
