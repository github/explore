---
display_name: Runtime Node
short_description: A secure, distroless Node.js Docker base image built entirely FROM scratch.
topic: runtime-node
aliases: node-runtime, distroless-node
related: nodejs, docker, distroless, containers, security
github_url: https://github.com/Runtimes-Node/Runtime-Node
url: https://hub.docker.com/r/runtimenode/runtime-node
created_by: Runtimes-Node
---

**[Runtime Node](https://github.com/Runtimes-Node/Runtime-Node)** is an open-source, production-grade Docker base image tailored for executing [Node.js](https://github.com/topics/nodejs) applications with maximum security and minimal overhead. Managed under the **[Runtimes-Node](https://github.com/Runtimes-Node)** organization, it provides developers with a strictly distroless runtime environment for their containerized workloads.

Unlike traditional Node.js base images built on Debian or Alpine Linux, Runtime Node is assembled entirely `FROM scratch`. It completely eliminates the operating system layer, shells (like `bash` or `sh`), package managers (`apt` or `apk`), and all system utilities. It achieves this by extracting only the hand-picked binaries and shared libraries strictly required by the Node.js runtime.

### Key Characteristics

* **Zero-Bloat Footprint:** By shipping only what Node.js needs, the image size is radically reduced to approximately ~45 MB compressed.
* **Hardened Security:** Removing the OS and shell results in zero known vulnerabilities and drastically shrinks the attack surface. 
* **Production Ready Defaults:** The image is pre-configured with `NODE_ENV=production` and `TZ=UTC`, and includes essential routing like CA Certificates, `nsswitch.conf`, and IANA tzdata.
* **Multi-Platform Architecture:** Natively supports both `linux/amd64` and `linux/arm64` deployments.

By enforcing a strict distroless guarantee, the [Runtime-Node repository](https://github.com/Runtimes-Node/Runtime-Node) and its corresponding **[Docker Hub image](https://hub.docker.com/r/runtimenode/runtime-node)** allow developers to ship code securely, knowing there are no unnecessary tools for attackers to exploit.