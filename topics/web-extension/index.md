---
display_name: Web extension/browser extension
short_description: A browser extension is a way to add customization to a browser.
topic: web-extension
aliases: browser-extension, webextension
related: chrome-extension, firefox-extension, safari-extension
url: https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions
wikipedia_url: https://en.wikipedia.org/wiki/Browser_extension
---
A **browser extension** or **web extension** (also written as **WebExtension**) is a way to customize various aspect of a browser's functionality:
* user interface modifications
* cookie management
* ad blocking
* custom scripting and styling of web pages

Other than browser plugins, they are distributed as source code, while plugins are executable.

While there is a [common standard](https://en.wikipedia.org/wiki/Manifest_file#WebExtension_manifest) (to which Mozilla switched in 2015), there are slight differences between the browser's implementations of said standard:
* [Mozilla Firefox](https://github.com/topics/firefox-extension) (gecko engine)
    * gecko uses `browser` when referring to the browser object in scripts, but supports using `chrome`
    * supports non-persistent background scripts called "event-driven background scripts"
* [Google Chrome](https://github.com/topics/firefox-extension) (webkit engine)
    * webkit uses `chrome` when referring to the browser object in scripts
    * instead of event-driven background scripts, Chrome has service workers
* Apple's [Safari](https://github.com/topics/firefox-extension) (also webkit)
* _Browser-specific settings can be applied to the `browser_specific_settings` key in the `manifest.json`_

The WebExtension manifest standard is currently in version 3 (called "Manifest V3"), but Firefox still supports version 2 (called "Manifest V2").
* Some key names changed (e.g. `browser_action` to `action`)

An extension is roughly divided into parts, of which not all might be used:
* **content scripts:** Scripts that manipulate the web page of the current tab
* **background scripts:** Scripts that don't have access to the web page but can do other tasks, including displaying a popup when clicked on the extension icon
    
