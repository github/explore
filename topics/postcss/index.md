---
topic: postcss
display_name: PostCSS
short_description: PostCSS is a tool for transforming CSS with JavaScript. It can be used to develop a template language such as Sass and LESS.
wikipedia_url: https://en.wikipedia.org/wiki/PostCSS
url: https://postcss.org/
github_url: https://github.com/postcss
created_by: Andrey Sitnik, Ben Briggs, Bogdan Chadkin
released: November 4, 2013
related: sass, less, ast
---
**PostCSS** is a tool for transforming CSS with JavaScript. It can be used to develop a template language such as Sass and LESS. The PostCSS core consists of:
* CSS parser that generates an [abstract syntax tree](/topics/abstract-syntax-tree)
* Set of classes that comprises the tree
* CSS generator that generates a CSS line for the object tree
* Code map generator for the CSS changes made#

There are official tools making it possible to use PostCSS with build systems such as [Webpack](/topics/webpack), [Gulp](/topics/gulp), and [Grunt](/topics/grunt). There is also a console interface available. [Browserify](/topics/browserify) or Webpack can be used to open PostCSS in a browser.

The complete plugin list can be found on postcss.parts, with some examples listed below.
* [Autoprefixer](/topics/autoprefixer) to add and clear [browser prefixes](/topics/vendor-prefix).
* [CSS Modules](/topics/css-modules) to get [CSS selectors](/topics/css-selectors) isolated and code organized. It is supplied as part of Webpack.
* [stylelint](/topics/stylelint) to analyze CSS code for mistakes and check style consistency.
* stylefmt fixes the CSS code according to the stylelint settings.
* PreCSS to perform some Sass/Less preprocessing functions.
* postcss-preset-env to emulate features from unfinished CSS specification drafts.
* [cssnano](/topics/cssnano) to make CSS smaller in size by getting rid of the spaces and rewriting the code.
* [RTLCSS](/RTLCSS) to change CSS code so that the design should be suitable for right-to-left writing (such is applied in Arabic and Hebrew).
* postcss-assets, postcss-inline-svg and postcss-sprites to work with graphics.
