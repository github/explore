# AI Office Orchestrator

Task -> score providers (health, quality, success, speed, cost) -> circuit breaker
-> adapter -> output checker -> failover to next provider.

- Side-effect tasks (email, publish, calendar) need `approved=True` and never fail over.
- Optional `ConsentGate` (app/core/consent.py): one-time, expiring token bound to the exact task; replays and mismatches are refused.
- Credentials come from environment variables only (see `.env.example`).
- Adapters are unverified against live APIs. Run tests: `python -m unittest discover -s tests -t .`
- Providers: openai, gemini, claude, grok (xAI), meta, canva. See `docs_provider_reference.md`.
