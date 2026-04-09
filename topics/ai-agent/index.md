---
aliases: agent-harnesses, ai-agent-harness, llm-harness
display_name: Agent Harness
short_description: Runtime infrastructure that connects LLMs to real-world tools, memory, and execution environments.
topic: agent-harness
related:
  - ai-agent
  - orchestration
  - tool-use
  - mcp
  - llm
---
<!-- markdownlint-disable MD041 -->

An **agent harness** is the runtime layer between a large language model and the outside world. It manages the agentic loop — prompt the model, parse tool calls, execute tools, feed results back — while enforcing permissions, compressing context, and handling error recovery. The term gained traction after Anthropic's Claude Code source was studied, revealing the internal architecture that turns a text-generating LLM into a capable software-engineering agent.

Agent harness projects include full runtime environments (LobeHub, oh-my-agent, HexAgent, Utah), agent harness frameworks for Python and TypeScript (water, Chorus), code-quality agents (desloppify), portable skill systems (cc-harness-skills, oh-my-agent), research surveys (LLM-Agent-Harness-Survey), and autonomous systems with persistent memory and orchestration (Adam, Sibyl). The pattern is characterized by a tool registry, a permission system, context management, and often multi-agent coordination.
