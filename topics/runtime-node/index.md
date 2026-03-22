---
display_name: Runtime Node
short_description: A secure, distroless Node.js Docker base image built entirely FROM scratch.
topic: runtime-node
aliases: node-runtime, distroless-node, scratch-node, secure-node, hardened-node
related: nodejs, docker, distroless, containers, security
github_url: https://github.com/Runtimes-Node/Runtime-Node
url: https://hub.docker.com/r/runtimenode/runtime-node
logo: runtime-node.png
created_by: Runtimes-Node
---

**[Runtime Node](https://github.com/Runtimes-Node/Runtime-Node)** is an open source, production-grade Docker base image tailored for executing [Node.js](https://github.com/topics/nodejs) applications. Managed by **[Runtimes-Node](https://github.com/Runtimes-Node)**, it provides developers with a strictly distroless runtime environment.

Unlike traditional Node.js base images, Runtime Node is assembled `FROM scratch`. It completely eliminates the operating system layer, shells, package managers, and system utilities, retaining only the exact binaries required by Node.js.

### Key Characteristics
* **Zero-Bloat:** Radically reduced to ~45 MB compressed.
* **Hardened Security:** Zero known vulnerabilities and a minimal attack surface.
* **Production Ready:** Pre-configured with `NODE_ENV=production` and `TZ=UTC`.
* **Multi-Platform:** Supports `linux/amd64` and `linux/arm64`.

This distroless guarantee ensures code is shipped securely with no unnecessary tools to exploit.