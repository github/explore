---
topic: cors
display_name: Cross-origin resource sharing (CORS)
short_description: CORS is a mechanism that allows restricted resources on a web page to be accessed from another domain outside the domain.
related: xhr, ajax, jsonp, content-security-policy
wikipedia_url: https://en.wikipedia.org/wiki/Cross-origin_resource_sharing
url: https://fetch.spec.whatwg.org/#http-cors-protocol
created_by: WHATWG, Matt Oshry, Brad Porter, Michael Bodell, Tellme Networks
released: May 2006
---
**Cross-origin resource sharing** (**CORS**) is a mechanism that allows restricted resources on a web page to be accessed from another domain outside the domain from which the first resource was served. CORS also relies on a mechanism by which browsers make a "preflight" request to the server hosting the cross-origin resource, in order to check that the server will permit the actual request. In that preflight, the browser sends headers that indicate the HTTP method and headers that will be used in the actual request. For security reasons, browsers restrict cross-origin HTTP requests initiated from scripts. For example, `fetch()` and `XMLHttpRequest` follow the same-origin policy. This means that a web application using those APIs can only request resources from the same origin the application was loaded from unless the response from other origins includes the right CORS headers.

# Resource types
* Invocations of `fetch()` or `XMLHttpRequest`
* Web Fonts (for cross-domain font usage in `@font-face` within CSS), so that servers can deploy TrueType fonts that can only be loaded cross-origin and used by websites that are permitted to do so
* WebGL textures
* Images/video frames drawn to a canvas using `drawImage()`
* CSS shapes from images
* scripts
* iframes
