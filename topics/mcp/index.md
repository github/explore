---
display_name: MCP
topic: mcp
aliases: model-context-protocol
related: mcp-server, ai-agent, llm, agent-harness
short_description: Model Context Protocol (MCP) is an open standard for connecting AI models to external tools and data sources.
created_by: Anthropic
url: https://modelcontextprotocol.io
released: November 2024
---

Model Context Protocol (MCP) is an open standard that defines how AI applications connect to external tools, data sources, and services. MCP uses a client-server architecture where AI-powered applications (clients) communicate with lightweight programs (servers) that expose specific capabilities through a standardized interface.

MCP servers can provide tools (executable functions), resources (read-only data), and prompts (reusable templates). The protocol supports multiple transport mechanisms including stdio for local processes and HTTP with Server-Sent Events for remote connections.

The protocol was created by Anthropic and released as an open specification. It is supported by AI tools including Claude Code, Cursor, Codex, Windsurf, and Claude Desktop.
