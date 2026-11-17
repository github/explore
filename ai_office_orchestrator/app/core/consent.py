"""Consent gate for side-effect tasks (send email, publish, create event ...).

A token is bound to the exact task content (kind + prompt), expires, and can be
used once. Consuming it before the call means a retry or failover can never
repeat the action; a new approval is needed to try again."""
import hashlib
import json
import secrets
import time


def fingerprint(task) -> str:
    return hashlib.sha256(f"{task.kind}\x00{task.prompt}".encode()).hexdigest()


class ConsentGate:
    def __init__(self, ttl=300, audit_path=None, clock=time.time):
        self.ttl, self.audit_path, self.clock = ttl, audit_path, clock
        self._tokens = {}  # token -> (fingerprint, expires_at)

    def approve(self, task) -> str:
        """Called by a human-facing layer after the user confirmed this task."""
        token = secrets.token_urlsafe(16)
        self._tokens[token] = (fingerprint(task), self.clock() + self.ttl)
        self._log("approved", task)
        return token

    def consume(self, task, token) -> bool:
        entry = self._tokens.pop(token, None) if token else None
        ok = bool(entry) and entry[0] == fingerprint(task) and self.clock() <= entry[1]
        self._log("consumed" if ok else "denied", task)
        return ok

    def _log(self, event, task):
        if not self.audit_path:
            return
        row = {"t": self.clock(), "event": event, "kind": task.kind,
               "fp": fingerprint(task)[:12]}  # no prompt text, no token in the log
        with open(self.audit_path, "a") as f:
            f.write(json.dumps(row) + "\n")
