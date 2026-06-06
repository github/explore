---
display_name: MCP Server
topic: mcp-server
aliases: mcp-servers
related: mcp, model-context-protocol, ai-agent, llm
short_description: MCP servers expose tools, resources, and prompts to AI applications through the Model Context Protocol.
url: https://modelcontextprotocol.io
---

MCP servers are lightweight programs that expose specific capabilities to AI applications through the Model Context Protocol (MCP). Each server acts as a bridge between AI models and external systems, providing tools (executable functions), resources (read-only data), and prompts (reusable templates) through a standardized interface.

MCP servers communicate with AI-powered clients over stdio for local processes or HTTP with Server-Sent Events for remote connections. They can integrate with databases, APIs, file systems, development tools, and cloud services. A single AI application can connect to multiple MCP servers simultaneously.

The MCP server ecosystem includes registries such as the official MCP Registry, Glama, and Smithery, where developers publish and discover servers for specific use cases.
