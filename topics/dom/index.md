---
aliases: dom-tree, dom-node, dom-element, dom-elements
created_by: World Wide Web Consortium
display_name: Document Object Model (DOM)
github_url: https://github.com/whatwg/dom
released: October 1, 1998
short_description: DOM is a cross-platform and language-independent interface that treats an HTML or XML document as a tree structure.
topic: dom
url: https://dom.spec.whatwg.org/
wikipedia_url: https://en.wikipedia.org/wiki/Document_Object_Model
related: shadow-dom, virtual-dom, html, xml, dhtml
---
**DOM** (short for **D**ocument **O**bject **M**odel) is a cross-platform and language-independent interface that treats an HTML or XML document as a tree structure wherein each node is an object representing a part of the document. The DOM represents a document with a logical tree. Each branch of the tree ends in a node, and each node contains objects. DOM methods allow programmatic access to the tree; with them one can change the structure, style or content of a document. Nodes can have event handlers (also known as event listeners) attached to them. Once an event is triggered, the event handlers get executed.

The principal standardization of the DOM was handled by the World Wide Web Consortium (W3C), which last developed a recommendation in 2004. WHATWG took over the development of the standard, publishing it as a living document. The W3C now publishes stable snapshots of the WHATWG standard.

In HTML DOM (Document Object Model), every element is a node:
* A document is a document node.
* All HTML elements are element nodes.
* All HTML attributes are attribute nodes.
* Text inserted into HTML elements are text nodes.
* Comments are comment nodes.
