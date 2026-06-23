---
aliases: agent-loops, agentic-loops
display_name: Loop Engineering
related: ai-agents, llm, agentic-ai, automation, prompt-engineering
short_description: Designing recurring AI and coding agent systems that discover work, verify results, persist state, and re-run over time.
topic: loop-engineering
---
Loop Engineering is the practice of designing recurring systems for AI agents and coding agents. Instead of prompting an agent turn by turn, you build a loop that discovers work, delegates it to one or more agents, verifies the result against tests or other deterministic gates, persists state outside the model, decides what happens next, and runs again on a cadence, an event, or until a verifiable goal is reached. It sits above prompt, context, and harness engineering: those improve a single run, while loop engineering governs repeated agent work over time, including budgets, retries, escalation to humans, and stopping conditions.
