---
created_by: VKrishna04
display_name: Code Ledger
related: leetcode, geeksforgeeks, browser-extension, chrome-extension, firefox-extension, data-structures, algorithms, competitive-programming
short_description: Auto-commit DSA solutions from LeetCode, GeeksForGeeks, and Codeforces to a personal GitHub repository.
topic: code-ledger
url: https://codeledger.vkrishna04.me
logo: code-ledger.png
---
**Code Ledger** is an open source browser extension that watches for accepted submissions on LeetCode, GeeksForGeeks, and Codeforces, then commits the solution to a developer-owned GitHub repository automatically — no copy-pasting, no manual uploads.

Repositories tagged `code-ledger` follow a uniform layout managed entirely by the extension. Each problem lives under a `problems/` directory, identified by a canonical cross-platform ID when the problem exists on multiple platforms (for example, `problems/two-sum/leetcode/`), or a platform-prefixed ID otherwise (`problems/lc-1/`). Inside each directory the extension writes the solution file and a `README.md` that GitHub renders directly — containing a metadata table with difficulty, solve date, runtime, and memory percentiles, the full problem statement, collapsible hints, and an optional AI-generated code review. A root-level `index.json` tracks every solved problem and keeps the repository in sync across devices.

The extension also provides a built-in library panel — accessible as a browser sidebar or at the hosted web app — with a searchable problem archive, solve-time analytics, a dependency graph across problems, and an AI chat history viewer. The library works in both extension and standalone modes, reading from IndexedDB locally or from the linked GitHub repository when accessed on the web.

The extension works in Chromium-based browsers and Firefox. Developers link it to an existing repository or let it create one, after which every accepted submission commits automatically — building a searchable, structured archive of their problem-solving history over time.

