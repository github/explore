---
display_name: Agent Browser
topic: agent-browser
aliases: browser-for-agents, ai-browser, agent-web-browser
related: mcp, browser-automation, web-automation, headless-browser, ai-agents
short_description: Browsers and browser engines built for AI agents to fetch, render, search, and act on the web programmatically.
created_by: Browser-use, AginxBrowser, and the agent tooling community
released: 2024
---

Agent browsers are web browsers or browser engines designed to be driven by AI agents rather than humans. Instead of a graphical interface, they expose programmatic surfaces — HTTP APIs, MCP servers, CDP endpoints — so an autonomous agent can fetch pages as clean text (typically markdown), render JavaScript-heavy SPAs, take screenshots as visual input, run aggregated searches, and drive multi-step interactions such as logins and pagination.

Common capabilities in this category:

- **Read**: HTML-to-markdown conversion and structured data extraction from JS-rendered pages
- **See**: screenshot rendering of the post-JS DOM as vision input for multimodal models
- **Find**: meta-search across multiple engines with result merging and deduplication
- **Act**: persistent sessions with indexed interaction (click/type by element index), cookie import/export for login flows
- **Evade**: real TLS fingerprints and challenge handling for anti-bot protected sites

Implementations range from wrappers around full Chromium (Puppeteer/Playwright-based) to standalone engine binaries that embed their own JavaScript runtime and renderer. The [Model Context Protocol](https://github.com/topics/mcp) has become a common control plane for exposing agent browsers to tools like Claude Code and Cursor.
