# Contributing

Hi there! We're excited you've got ideas for an existing or new topic page. Your help makes Explore valuable to others in your community.

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

There are a few ways you can contribute: improving an existing topic page, or curating a new topic page.

As you write content, check out the [Style Guide](./docs/styleguide.md) to learn what each field means, and how they should be formatted. Following the style guide will improve the chances of your contribution being accepted.

Note: updates won't immediately appear once we've merged your PR. We pull in these changes regularly to GitHub.

## Improving an existing topic page

If a topic page already exists, it will be listed in the [topics directory](https://github.com/github/explore/tree/master/topics). The topic name should match its URL, e.g. `https://github.com/topics/rails` corresponds to the [`rails` folder](https://github.com/github/explore/tree/master/topics/rails).

To improve an existing topic page, please **open a pull request** with your proposed changes:

* To update the image, replace the image inside the topic's folder
* To update the content, edit the `index.md` inside the topic's folder

The [pull request template](./.github/PULL_REQUEST_TEMPLATE.md) provides guidance on the information you need to include.

**Please fill out the pull request template completely.** If you do not fill out the template, your PR will be closed.

## Curating a new topic page

If a topic page is not yet curated, it will NOT be listed in the [topics directory](https://github.com/github/explore/tree/master/topics). The default layout on `https://github.com/topics/foo` looks like this:

![topic page](https://user-images.githubusercontent.com/1840802/30932236-c9c397d2-a37b-11e7-94be-5c9847ea2d71.png)

We are likely to consider suggestions to curate a topic page that is valuable to GitHub's community. Valuable topics include those that are already [widely used by repositories](https://help.github.com/articles/classifying-your-repository-with-topics/), or a topic that currently lacks important information. When suggesting content for a topic page, please consider how to make your contribution broadly useful and relevant to others, rather than serving a specific use case.

Please note that all suggestions must adhere to GitHub's [Community Guidelines](https://help.github.com/articles/github-community-guidelines/) and [Terms of Service](https://help.github.com/articles/github-terms-of-service/). Per our Terms of Service, [you are responsible](https://help.github.com/articles/github-terms-of-service/#d-user-generated-content) for the content you contribute, and you must have the rights to use it.

To propose a new topic page, please **open an pull request** with your proposed changes. The [API docs](./docs/API.md) and [style guide](./docs/styleguide.md) provide guidance on the information you need to include and how it should be formatted.

**Please fill out the pull request template completely.** If you do not fill out the template, your pull request will be closed.

## Running tests

There are some lint tests in place to ensure each topic is formatted in the way we expect. Travis
CI will run the tests automatically. If you want to run the tests yourself locally, you will need
Ruby and Bundler installed.

You can run the tests using:

```bash
script/cibuild
```
