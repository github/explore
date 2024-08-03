name: Check for conflicts of interest

on:
  pull_request:

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - run: |
          echo "In order to review this pull request for acceptance, we need to make sure that all of the prerequisites are satisfied."
          echo "This was not checked:"
          echo "> I have no affiliation with the project I am suggesting (as a maintainer, creator, contractor, or employee)"
          echo "This is a requirement to maintain a high level of independence in this project. Please update if you are able to verify that you meet that requirement."
          echo "Thank you!"
          exit 1
        if: contains(github.event.pull_request.body, '- [ ] I have no affiliation with the project I am suggesting (as a maintainer, creator, contractor, or employee).')
        name: Fail
      - run: exit 0
        if: contains(github.event.pull_request.body, '- [x] I have no affiliation with the project I am suggesting (as a maintainer, creator, contractor, or employee).')
        name: Succeed
