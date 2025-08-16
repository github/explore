---
related: long-polling, polling
aliases: websockets, ws
created_by: Michael Carter, Ian Hickson
display_name: WebSocket
short_description: The WebSocket protocol enables web applications to maintain bidirectional communications with server-side processes.
topic: websocket
url: https://websockets.spec.whatwg.org/
wikipedia_url: https://en.wikipedia.org/wiki/WebSocket
---

WebSocket is a computer communications protocol, providing full-duplex communication channels for interaction between a web browser (or other client application) and a web server over a single TCP connection. The WebSocket protocol allows for sending messages to a server and receiving event-driven responses without having to poll the server for a reply, facilitating real-time data transfer from and to the server. This is made possible by providing a standardized way for the server to send content to the client without being first requested by the client, and allowing messages to be passed back and forth while keeping the connection open. In this way, a two-way ongoing conversation can take place between the client and the server.
