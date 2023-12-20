---
topic: openapi
aliases: open-api, swagger-spec, swagger-specification, openapi-spec, openapi-specification, open-api-specification, oas, openapi-description
display_name: OpenAPI Specification
short_description: The OpenAPI Specification is a specification for describing, producing, consuming, and visualizing web services.
related: json-schema, raml, rest-api
created_by: OpenAPI Initiative, Tony Tam, Darrel Miller, Mike Ralphson, Ron Ratovsky, Uri Sarid, Jason Harmon
released: August 10, 2011
url: https://www.openapis.org/
wikipedia_url: https://en.wikipedia.org/wiki/OpenAPI_Specification
github_url: https://github.com/OAI/OpenAPI-Specification
---
The **OpenAPI Specification** (**OAS**), previously known as the **Swagger Specification**, is a specification for a programming language-agnostic, machine-readable interface definition language for describing, producing, consuming, and visualizing web services. OpenAPI documents describe API services and are represented in YAML or JSON formats.

# Features
* **Description Validation and [Linting](/topics/linting)**: Can check that the description file is syntactically correct and adheres to a specific version of the specification and the rest of the team’s formatting guidelines.
* **[Data Validation](/topics/data-validation)**: Can check that the data flowing through the API (in both directions) is correct, during development and once deployed.
* **[Documentation Generation](/topics/documentation-generation)**: Can create traditional human-readable documentation based on the machine-readable description, which always stays up-to-date.
* **[Code Generation](/topics/code-generation)**: Can create both server and client code in any programming language, freeing developers from having to perform data validation or write SDK glue code, for example.
* **Graphical Editors**: Allows easy creation of description files using a GUI instead of typing them by hand.
* **[Mock Servers](/topics/mock-server)**: Can create fake servers providing example responses which can be tested by developers and customers before writing a single line of code.
* **[Security Analysis](/topics/security-analysis)**: Discovers possible vulnerabilities at the API design stage instead of much, much later.
* A non-proprietary format

