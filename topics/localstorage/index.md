---
aliases: local-storage
display_name: LocalStorage
short_description: LocalStorage is a JavaScript object that allows storing arbitrary key-value pairs in the web browser as an alternative to cookies.
topic: localstorage
url: https://html.spec.whatwg.org/multipage/webstorage.html#dom-localstorage-dev
wikipedia_url: https://en.wikipedia.org/wiki/Web_storage
related: sessionstorage, indexeddb, websql, web-storage, webstorage
---
LocalStorage is a JavaScript object that allows storing arbitrary key-value pairs in the web browser as an alternative to cookies&mdash;another alternative if the data in question goes beyond key-value pairs is to use the IndexedDB.

`localStorage` data is specific to the protocol of the document. In particular, for a site loaded over HTTP (e.g., http://example.com), `localStorage` returns a different object than `localStorage` for the corresponding site loaded over HTTPS (e.g., https://example.com).
