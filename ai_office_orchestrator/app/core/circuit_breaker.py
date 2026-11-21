import time


class CircuitBreaker:
    CLOSED, OPEN, HALF_OPEN = "CLOSED", "OPEN", "HALF_OPEN"

    def __init__(self, threshold=3, recovery_seconds=30, clock=time.monotonic):
        self.threshold, self.recovery, self.clock = threshold, recovery_seconds, clock
        self.failures, self.opened_at, self._state = 0, 0.0, self.CLOSED

    @property
    def state(self):
        if self._state == self.OPEN and self.clock() - self.opened_at >= self.recovery:
            self._state = self.HALF_OPEN
        return self._state

    def allow(self):
        return self.state != self.OPEN

    def success(self):
        self.failures, self._state = 0, self.CLOSED

    def failure(self):
        self.failures += 1
        if self._state == self.HALF_OPEN or self.failures >= self.threshold:
            self._state, self.opened_at = self.OPEN, self.clock()
