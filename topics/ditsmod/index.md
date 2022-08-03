---
created_by: Костя Третяк
display_name: Ditsmod
github_url: https://github.com/ditsmod/ditsmod
released: May 23, 2021
short_description: Ditsmod is a Node.js web framework, written in TypeScript.
topic: ditsmod
url: https://ditsmod.github.io/
---
Ditsmod is a Node.js web framework, named **DI** + **TS** + **Mod** to emphasize its important components: it has **D**ependency **I**njection, written in **T**ype**S**cript, and designed for good **Mod**ularity.

The main features of Ditsmod:

- Modular architecture on decorators, which allows you to declaratively describe the structure of the application.
- Convenient mechanism for [specifying and resolving][8] between different application classes: you in constructor specify instances of which classes you need, and DI undertakes a difficult task "how to get it".
- Ability to write your own extensions (sometimes called plugins) that can be asynchronously initialized and that can depend on each other.
- Ability to dynamically add and remove modules after starting the web server, without the need to restart.
- Has OpenAPI support, and has the ability to validate queries based on OpenAPI metadata.
- To date, [Ditsmod is one of the fastest][14] among Node.js web frameworks.

Some concepts of Ditsmod architecture are taken from [Angular][9] concepts. Module [DI][11] is actually extracted from Angular v4.4.7. (with minimal modifications) and integrated into Ditsmod.


[8]: https://en.wikipedia.org/wiki/Dependency_injection
[9]: https://github.com/angular/angular
[11]: https://github.com/ts-stack/di
[14]: https://github.com/ditsmod/vs-webframework#readme
