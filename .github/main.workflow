workflow "test" {
  resolves = ["CI Test Runner"]
  on = "pull_request"
}

action "CI Test Runner" {
  uses = "./.github/test_runner"
}
