{
  "name": "create-pull-request",
  "version": "3.0.0",
  "private": true,
  "description": "Creates a pull request for changes to your repository in the actions workspace",
  "main": "lib/main.js",
  "scripts": {
    "build": "tsc && ncc build",
    "format": "prettier --write '**/*.ts'",
    "format-check": "prettier --check '**/*.ts'",
    "lint": "eslint src/**/*.ts",
    "test:unit": "jest unit",
    "test:int": "__test__/integration-tests.sh",
    "test": "npm run test:unit && npm run test:int"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/peter-evans/create-pull-request.git"
  },
  "keywords": [
    "actions",
    "pull",
    "request"
  ],
  "author": "Peter Evans",
  "license": "MIT",
  "bugs": {
    "url": "https://github.com/peter-evans/create-pull-request/issues"
  },
  "homepage": "https://github.com/peter-evans/create-pull-request",
  "dependencies": {
    "@actions/core": "1.2.6",
    "@actions/exec": "1.0.4",
    "@octokit/core": "3.2.4",
    "@octokit/plugin-paginate-rest": "2.8.0",
    "@octokit/plugin-rest-endpoint-methods": "4.5.2",
    "uuid": "8.3.2"
  },
  "devDependencies": {
    "@types/jest": "26.0.20",
    "@types/node": "14.14.22",
    "@typescript-eslint/parser": "4.14.0",
    "@vercel/ncc": "0.27.0",
    "eslint": "7.18.0",
    "eslint-plugin-github": "4.1.1",
    "eslint-plugin-jest": "24.1.3",
    "jest": "26.6.3",
    "jest-circus": "26.6.3",
    "js-yaml": "4.0.0",
    "prettier": "2.2.1",
    "ts-jest": "26.4.4",
    "typescript": "4.1.3"
  }
}
# Contributing

Hi there! We're excited you've got ideas to improve topics and collections. You're helping the community discover valuable information.

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

There are a few ways you can contribute:

- Improving an existing topic or collection
- Curating a new topic or collection

As you write content, check out the [Style Guide](./docs/styleguide.md) to learn what each field means, and how it should be formatted. Following the style guide will increase the chances of your contribution being accepted.

Notes: 
  - Updates won't immediately appear once we've merged your PR. We pull in these changes regularly to GitHub.
  - Please limit your pull request to the creation/updating of one topic or collection at a time.

## Improving an existing topic or collection

If a topic or collection already exists, it will be listed in its respective directory:

- [topics/](https://github.com/github/explore/tree/main/topics)
- [collections/](https://github.com/github/explore/tree/main/collections)

The topic or collection name should match its URL, e.g. `https://github.com/topics/rails` corresponds to the [`topics/rails` directory](https://github.com/github/explore/tree/main/topics/rails).

To make an improvement, please **open a pull request** with your proposed changes:

### Update the image

To update the image, simply replace the image inside the directory for the topic or collection.

### Update text and links

To update text and links, edit the `index.md` inside the topic or collection's directory. These files are formatted using a combination of [Front Matter](https://jekyllrb.com/docs/frontmatter/) and simple body content.

For **topics**, you'll notice that, in examples like the topic "[algorithm](https://raw.githubusercontent.com/github/explore/main/topics/algorithm/index.md)," data like its canonical URL, Wikipedia URL, or display name are called out in key-value pairs, while its detailed description is accounted for in the body of the document.

_/topics/algorithm/index.md_:
```
---
aliases: algorithms
display_name: Algorithm
short_description: Algorithms are self-contained sequences that carry out a variety of tasks.
topic: algorithm
wikipedia_url: https://en.wikipedia.org/wiki/Algorithm
---
Algorithms are detailed sets of guidelines created for a computer program to complete tasks efficiently and thoroughly.
```

---

Similarly, **collections** like "[music](https://raw.githubusercontent.com/github/explore/main/collections/music/index.md)" call out things like their author and display name in Front Matter variables -- with a detailed description in the body of the document. Most importantly, though, collections identify their individual collection items in [a YAML list](https://en.wikipedia.org/wiki/YAML#Basic_components) for the key "items."

_/collections/music/index.md_:

```
---
items:
 - beetbox/beets
 - scottschiller/SoundManager2
 - CreateJS/SoundJS
 - musescore/MuseScore
 - tomahawk-player/tomahawk
 - cashmusic/platform
 - mopidy/mopidy
 - AudioKit/AudioKit
 - Soundnode/soundnode-app
 - gillesdemey/Cumulus
 - metabrainz/picard
 - overtone/overtone
 - samaaron/sonic-pi
display_name: Music
created_by: jonrohan
---
Drop the code bass with these musically themed repositories.
```

---

The [pull request template](./.github/PULL_REQUEST_TEMPLATE.md) also provides guidance on the information you need to include.

**Please fill out the pull request template completely.** If you do not fill out the template, your PR will be closed.

## Curating a new topic or collection

If a topic or collection is not yet curated, it will NOT be listed in its respective directory.

We are likely to consider suggestions to curate a topic or collection that is valuable to GitHub's community. Valuable topics, for example, include those that are already [widely used by repositories](https://help.github.com/articles/classifying-your-repository-with-topics/) and could benefit from the addition of important information. When suggesting content, please consider how to make your contribution broadly useful and relevant to others, rather than serving a specific use case.

Please note that all suggestions must adhere to GitHub's [Community Guidelines](https://help.github.com/articles/github-community-guidelines/) and [Terms of Service](https://help.github.com/articles/github-terms-of-service/). Per our Terms of Service, [you are responsible](https://help.github.com/articles/github-terms-of-service/#d-user-generated-content) for the content you contribute, and you must have the rights to use it.

To propose a new topic or collection, please **open a pull request** with your proposed additions. The [API docs](./docs/API.md) and [style guide](./docs/styleguide.md) provide guidance on the information you need to include and how it should be formatted.

This repository includes [a list of the most-used GitHub topics that don't yet have extra context](topics-todo.md). If your pull request adds one of these topics, please update topics-todo.md so that the topic is checked (marked complete).

**Please fill out the pull request template completely.** If you do not fill out the template, your pull request will be closed.

## Guidelines

* Avoid conflicts of interest. Maintainers of a project cannot add a topic or collection for their own project. If a topic is popular enough to warrant inclusion, someone else will add or improve it.

## Running tests

There are some lint tests in place to ensure each topic is formatted in the way we expect. Travis
CI will run the tests automatically. If you want to run the tests yourself locally, you will need
Ruby and Bundler installed.

You can run the tests using:

```bash
script/cibuild
```
