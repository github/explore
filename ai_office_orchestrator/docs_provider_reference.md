# Provider reference (UNVERIFIED)

docs.x.ai, ai.google.dev and platform.openai.com were not reachable from the
build session (network allowlist), so nothing here was checked against live docs.
Confirm each item on the official site before relying on it.

| Provider | Env var | SDK / endpoint used in code | Model in code | Status |
|---|---|---|---|---|
| OpenAI | OPENAI_API_KEY | `openai` SDK, Responses API | gpt-5 | unverified |
| Gemini (Google AI) | GEMINI_API_KEY | `google-genai`, `models.generate_content` | gemini-2.5-pro | unverified |
| Grok (xAI) | XAI_API_KEY | `openai` SDK, base_url https://api.x.ai/v1, chat.completions | grok-4 (override XAI_MODEL) | unverified |
| Claude | ANTHROPIC_API_KEY | `anthropic` SDK, Messages API | claude-sonnet-5-5 | unverified |

Note: the connected "Gemini" MCP connector is Gemini Trading (crypto exchange),
not Google Gemini AI. Do not use it for model calls.
