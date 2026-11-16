from .providers import ALL


def build_adapters():
    return [cls() for cls in ALL]
