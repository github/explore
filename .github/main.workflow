workflow "test" {
  resolves = ["CI Test Runner"]
  on = "push"
}

action "CI Test Runner" {
  uses = "./.github/test_runner"
}
