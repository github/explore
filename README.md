# GitHub Explore

This repository houses all of the community-curated content for GitHub Topics and Collections.

[Topics](https://help.github.com/articles/about-topics/) help you explore repositories in a particular subject area, learn more about that subject, and find projects to contribute to.

[Collections](https://github.com/collections) help you discover hand-picked repositories, developers, organizations, videos, and articles that share a common theme.

If you want to suggest edits to an existing topic page or collection, or curate a new one, read our [contributing guide](CONTRIBUTING.md) to get started. You can also [review a list of popular topics that need more context](topics-todo.md) to get an idea of where to start.

## Running tests

There are some lint tests in place to ensure each topic is formatted in the way we expect. GitHub
Actions will run the tests automatically. If you want to run the tests yourself locally, you will
need Ruby and Bundler installed.

You can run the tests using:

```bash
bundle install
bundle exec rubocop
```

You might encounter an error when bundler installs `rdiscount`. To resolve this, set the cflag:

```bash
bundle config build.rdiscount --with-cflags=-"Wno-error=implicit-function-declaration"
bundle install
```

Trouble following through? Here's a [video walkthrough](https://replayable.io/replay/639b2b10edb8ac0065938ab8/?share=f57E6Qva24xcJ8Mo5X26OA).

## Licenses

Content is released under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) which gives you permission to use content for almost any purpose (but does not grant you any trademark permissions). See [notices](notices.md) for complete details, including attribution guidelines, contribution terms, and software and third-party licenses and permissions.
