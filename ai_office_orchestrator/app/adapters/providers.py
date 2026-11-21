"""Real API adapters. SDKs are imported lazily so the core runs without them.
These are NOT verified against live APIs: no credentials were available."""
import json
import os
import urllib.request

from .base import BaseAdapter


class OpenAIAdapter(BaseAdapter):
    name, env_key = "openai", "OPENAI_API_KEY"
    kinds = ("text", "code", "research")
    metrics = dict(quality=0.9, success=0.9, speed=0.7, cost=0.4)

    def run(self, task):
        from openai import OpenAI
        client = OpenAI(api_key=self.credential())
        r = client.responses.create(model="gpt-5", input=task.prompt)
        return r.output_text


class GeminiAdapter(BaseAdapter):
    name, env_key = "gemini", "GEMINI_API_KEY"
    kinds = ("text", "research", "image", "video")
    metrics = dict(quality=0.85, success=0.9, speed=0.8, cost=0.6)

    def run(self, task):
        from google import genai
        client = genai.Client(api_key=self.credential())
        return client.models.generate_content(model="gemini-2.5-pro", contents=task.prompt).text


class ClaudeAdapter(BaseAdapter):
    name, env_key = "claude", "ANTHROPIC_API_KEY"
    kinds = ("text", "code", "research")
    metrics = dict(quality=0.92, success=0.9, speed=0.7, cost=0.4)

    def run(self, task):
        import anthropic
        client = anthropic.Anthropic(api_key=self.credential())
        m = client.messages.create(model="claude-sonnet-5-5", max_tokens=2048,
                                   messages=[{"role": "user", "content": task.prompt}])
        return "".join(b.text for b in m.content if b.type == "text")


class GrokAdapter(BaseAdapter):
    """xAI Grok via its OpenAI-compatible endpoint. Base URL and model name are
    unverified (docs.x.ai was unreachable); override with XAI_BASE_URL / XAI_MODEL."""
    name, env_key = "grok", "XAI_API_KEY"
    kinds = ("text", "code", "research")
    metrics = dict(quality=0.85, success=0.85, speed=0.75, cost=0.5)

    def run(self, task):
        from openai import OpenAI
        client = OpenAI(api_key=self.credential(),
                        base_url=os.getenv("XAI_BASE_URL", "https://api.x.ai/v1"))
        r = client.chat.completions.create(
            model=os.getenv("XAI_MODEL", "grok-4"),
            messages=[{"role": "user", "content": task.prompt}])
        return r.choices[0].message.content


class MetaAdapter(BaseAdapter):
    name, env_key = "meta", "MODEL_API_KEY"
    kinds = ("text",)
    metrics = dict(quality=0.75, success=0.8, speed=0.8, cost=0.7)
    base = "https://api.meta.ai/v1"

    def run(self, task):
        # Endpoint path/body are assumptions; confirm against Meta's docs.
        req = urllib.request.Request(
            f"{self.base}/chat/completions",
            data=json.dumps({"messages": [{"role": "user", "content": task.prompt}]}).encode(),
            headers={"Authorization": f"Bearer {self.credential()}",
                     "Content-Type": "application/json"})
        with urllib.request.urlopen(req, timeout=60) as r:
            return json.load(r)["choices"][0]["message"]["content"]


class CanvaAdapter(BaseAdapter):
    name, env_key = "canva", "CANVA_ACCESS_TOKEN"
    kinds = ("design",)
    metrics = dict(quality=0.8, success=0.8, speed=0.5, cost=0.5)

    def auth_check(self):
        return self.healthy()

    def run(self, task):
        raise NotImplementedError("Canva requires an OAuth flow; not implemented")


ALL = [OpenAIAdapter, GeminiAdapter, ClaudeAdapter, GrokAdapter, MetaAdapter, CanvaAdapter]
