---
topic: media-queries
aliases: media-query
display_name: Media Queries
short_description: Media Queries are a way to target browser by certain characteristics, features, and user preferences, then apply styles or run other code based on those things.
related: responsive-design, container-queries, client-hints, css-breakpoints, css-viewport
url: https://drafts.csswg.org/mediaqueries/
wikipedia_url: https://en.wikipedia.org/wiki/Media_queries
created_by: Håkon Wium Lie, W3C
released: June 19, 2012
---
**Media Queries** are a way to target browser by certain characteristics, features, and user preferences, then apply styles or run other code based on those things. They are a key part of responsive web design, as they allow you to create different layouts depending on the size of the viewport, but they can also be used to detect other things about the environment your site is running on, for example whether the user is using a touchscreen rather than a mouse. In this lesson you will first learn about the syntax used in media queries, and then move on to use them in a working example showing how a simple design might be made responsive. Media queries are used for the following:
* conditionally apply styles with the CSS `@media` and `@import` at-rules
* target specific media for the `<style>`, `<link>`, `<source>`, and other HTML elements with the `media=` attribute
* test and monitor media states using the `Window.matchMedia()` and `EventTarget.addEventListener()` methods

A media query is composed of an optional media type and any number of media feature expressions, which may optionally be combined in various ways using logical operators. Media queries are case-insensitive.
* Media types define the broad category of device for which the media query applies: all, print, screen. The type is optional (assumed to be all) except when using the not or only logical operators.
    * **all:** Suitable for all devices.
    * **print:** Intended for paged material and documents viewed on a screen in print preview mode.
    * **screen:** Intended primarily for screens.
* Media features describe a specific characteristic of the user agent, output device, or environment. Media Queries Level 4 groups 18 media features into 5 categories.
    * **Viewport/Page Characteristics**
    * **Display Quality**
    * **Color**
    * **Interaction**
    * **Video-prefixed:** The spec references user agents, including TVs, that render video and graphics in two separate planes that each have their own characteristics. The following features describe those planes. _(upcoming Media Queries Level 5)_
    * **Scripting** _(upcoming Media Queries Level 5)_
    * **User Preference** _(upcoming Media Queries Level 5)_
* Logical operators can be used to compose a complex media query: not, and, and only. You can also combine multiple media queries into a single rule by separating them with commas. 
