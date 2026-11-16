import sqlite3
import time


class MetricsStore:
    """Durable per-provider outcomes (SQLite). Feeds scoring with real success/speed."""

    def __init__(self, path=":memory:"):
        self.db = sqlite3.connect(path)
        self.db.execute("CREATE TABLE IF NOT EXISTS runs("
                        "provider TEXT, kind TEXT, ok INTEGER, seconds REAL, ts REAL)")

    def record(self, provider, kind, ok, seconds):
        self.db.execute("INSERT INTO runs VALUES(?,?,?,?,?)",
                        (provider, kind, int(ok), seconds, time.time()))
        self.db.commit()

    def observed(self, provider, kind, window=50):
        rows = self.db.execute(
            "SELECT ok, seconds FROM runs WHERE provider=? AND kind=? "
            "ORDER BY ts DESC LIMIT ?", (provider, kind, window)).fetchall()
        if not rows:
            return {}
        success = sum(r[0] for r in rows) / len(rows)
        avg = sum(r[1] for r in rows) / len(rows)
        return {"success": success, "speed": 1 / (1 + avg)}  # 0..1, faster = higher
