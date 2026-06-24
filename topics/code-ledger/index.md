---
created_by: Life-Experimentalist
display_name: Code Ledger
related: leetcode, geeksforgeeks, browser-extension, chrome-extension, firefox-extension, data-structures, algorithms, competitive-programming
short_description: Auto-commit data structure and algorithm solutions from LeetCode, GeeksForGeeks, and Codeforces to a personal GitHub repository.
topic: code-ledger
url: https://codeledger.vkrishna04.me
logo: code-ledger.png
---
**Code Ledger** is an open source browser extension that watches for accepted submissions on LeetCode, GeeksForGeeks, and Codeforces, then commits the solution to a developer-owned GitHub repository automatically, with no copy-pasting or manual uploads required.

Repositories tagged `code-ledger` follow a uniform layout managed entirely by the extension. Each problem lives under a `problems/` directory, identified by a canonical cross-platform ID when the problem appears on multiple platforms (for example, `problems/two-sum/leetcode/`), or a platform-prefixed ID otherwise (`problems/lc-1/`). Inside each directory the extension writes the solution file and a `README.md` that GitHub renders directly, containing a metadata table with difficulty, solve date, runtime, and memory percentiles, the full problem statement, collapsible hints, and an optional AI-generated code review. A root-level `index.json` tracks every solved problem and keeps the repository in sync across devices.

The extension is built on a modular, handler-based architecture where each supported platform is an independent plugin. LeetCode support is stable; GeeksForGeeks support is in beta; Codeforces support is in alpha. New platforms can be added by implementing a handler class, making it straightforward for the community to extend support to other coding sites.

The extension also includes a built-in library panel, accessible as a browser sidebar, with a searchable problem archive, solve-time analytics, a graph view connecting related problems, and an AI chat history viewer.

The extension works in Chromium-based browsers and Firefox. Developers link it to an existing repository or let it create one, after which every accepted submission commits automatically, building a searchable and structured archive of their problem-solving history over time.
