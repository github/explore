def check_output(output) -> tuple[bool, str]:
    """Return (ok, reason). Rejects empty or placeholder output."""
    if output is None or not str(output).strip():
        return False, "empty output"
    if str(output).strip().lower() in {"none", "null", "error", "n/a"}:
        return False, "placeholder output"
    return True, "ok"
