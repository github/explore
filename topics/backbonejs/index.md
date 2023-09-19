---
aliases: backbone
created_by: Jeremy Ashkenas
display_name: Backbone.js
logo: backbonejs.png
released: October 13, 2010
short_description: Backbone.js is a JavaScript library for building modern web apps and services.
topic: backbonejs
url: https://backbonejs.org/
wikipedia_url: https://en.wikipedia.org/wiki/Backbone.js
related: javascript, mvc, underscore, routing, jquery
---
**Backbone.js** supplies structure to JavaScript-heavy applications by providing models with key-value binding and custom events, collections with a rich API of enumerable functions, views with declarative event handling, and connects it all to your existing application over a RESTful JSON interface. Backbone.js was originally extracted from the Rails application [DocumentCloud](http://www.documentcloud.org/). Philosophically, Backbone is an attempt to discover the minimal set of data-structuring (models and collections) and user interface (views and URLs) primitives that are generally useful when building web applications with JavaScript. Backbone is a library, not a framework. Synchronous events are used as the fundamental building block over constantly polling data. The main pars of Backbone are:
* Events
* Models – Wraps a row of data in business logic. 
* Collections – A group of models on the client-side, with sorting/filtering/aggregation logic. 
* Router (+ History)
* Views (+ Client-side Templates) – A logical, re-usable piece of UI. Often, but not always, associated with a model.
* Sync – Synchronization between frontend and REST API backend 
