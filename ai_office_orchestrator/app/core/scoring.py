WEIGHTS = dict(health=0.30, quality=0.30, success=0.25, speed=0.10, cost=0.05)


def score(profile: dict, kind: str, healthy: bool) -> float:
    """Each metric is 0..1 (higher is better). -1 = not eligible."""
    if not healthy or kind not in profile.get("kinds", ()):
        return -1.0
    m = profile.get("metrics", {})
    total = WEIGHTS["health"]
    for k in ("quality", "success", "speed", "cost"):
        total += WEIGHTS[k] * m.get(k, 0.5)
    return round(total, 4)
