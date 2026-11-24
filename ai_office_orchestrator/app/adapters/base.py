import os


class MissingCredential(Exception):
    pass


class BaseAdapter:
    name = "base"
    env_key = ""
    kinds: tuple = ()
    metrics: dict = {}

    def credential(self):
        value = os.getenv(self.env_key, "").strip()
        if not value:
            raise MissingCredential(f"Missing required environment variable: {self.env_key}")
        return value

    def healthy(self) -> bool:
        return bool(os.getenv(self.env_key, "").strip())

    def profile(self):
        return {"kinds": self.kinds, "metrics": self.metrics}

    def run(self, task) -> str:
        raise NotImplementedError
