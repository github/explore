---
aliases: dependency-injection-pattern
topic: dependency-injection
display_name: Dependency injection
short_description: Dependency injection separates the depndency's implementation from the class that's using it by passing it in from outside.
related: separation-of-concerns, loose-coupling, dependency-inversion-principle, inversion-of-control, constructor-injection, service-locator-pattern, dependency-injection-container
wikipedia_url: https://en.wikipedia.org/wiki/Dependency_injection
url: https://martinfowler.com/articles/injection.html
created_by: Martin Fowler
released: January 23, 2004
---
**Dependency injection** (**DI**) is an implementation of the [dependency inversion principle](/topics/dependency-inversion-principle) with the aim of [separation of concerns](/topics/separation-of-concerns) by separating the depndency's implementation from the class that's using it. That kind of abstraction makes it possible to have different implementations with the same public methods so the class using it, doesn't need to care which of the implementations is used. This is also especially useful for [unit testing](/topics/unit-testing).

There are different types of dependency injection:
* [constructor injection](/topics/constructor-injection)
* [setter injection](/topics/setter-injection)
* [interface injection](/topics/interface-injection)
