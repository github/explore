---
display_name: "JSON:API"
created_by: Yehuda Katz, Dan Gebhardt, Gabe Sullice, Jeldrik Hanschke, Tyler Kellen, Steve Klabnik,Ethan Resnick
logo: json-api.png
released: May 3, 2013
short_description: "JSON:API is a specification for building APIs in JSON."
topic: json-api
url: https://jsonapi.org
related: json, emberjs, rest-api, json-ld, hal, hateoas, siren, hydra, collection-json
---
**JSON:API** is a specification for how a client should request that resources be fetched or modified, and how a server should respond to those requests. JSON:API is designed to minimize both the number of requests and the amount of data transmitted between clients and servers. This first draft was extracted from the JSON transport implicitly defined by Ember Data’s REST adapter. In general, Ember Data’s goal is to eliminate the need for ad-hoc code per application to communicate with servers that communicate in a well-defined way. The REST Adapter in Ember Data implicitly defined a protocol that custom servers could implement to get a drop-in client for all of their resources. The goals of the media type are to balance:

* A generic media type that can work across a broad set of use cases, including the generally used relationship types
* Similarity to existing server-side framework practices (and human readability for debugging)
* Ease of implementation on the server side
* Ease of implementation on the client side

This specification reached a stable version 1.0 on May 29, 2015.
