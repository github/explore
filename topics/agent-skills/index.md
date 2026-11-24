---
aliases: agent-skill, ai-agent-skills
display_name: Agent Skills
related: agent-harness, ai-agents, coding-agents, mcp, claude-code, prompt-engineering
short_description: Agent skills are reusable bundles of instructions and resources that an AI agent loads on demand.
topic: agent-skills
---
Agent skills are self-contained bundles of instructions, reference material, and scripts that an AI agent loads only when a task calls for them. A skill declares what it covers and when it applies, so the agent decides for itself whether to pull it into context instead of carrying every instruction at all times.

The pattern lets an agent's capabilities grow without its working context growing with them. Authors publish skills as plain files in a repository, and users install the ones they need. Agent skills are commonly paired with agent harnesses and the Model Context Protocol, and are used to capture coding conventions, design systems, domain workflows, and organization-specific procedures.
