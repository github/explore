from dataclasses import dataclass, field


@dataclass
class Task:
    kind: str                      # text | code | image | video | research ...
    prompt: str
    side_effect: bool = False      # send email, publish, create event ...
    approved: bool = False         # consent gate for side-effect tasks
    meta: dict = field(default_factory=dict)


@dataclass
class Result:
    provider: str
    output: str
    attempts: list = field(default_factory=list)
