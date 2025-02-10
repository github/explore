# frozen_string_literal: true

require "minitest/autorun"
require "fastimage"
require "uri"
require "yaml"
require "octokit"
require "json"
require "httparty"

IMAGE_WIDTH = 288
IMAGE_HEIGHT = 288
MAX_IMAGE_FILESIZE_IN_BYTES = 75_000
EXPLORE_FEED_URL = "https://github.github.io/explore/feed.json"
GRAPHQL_ENDPOINT = "/graphql"
UNSAFE_TO_SAFE_STRING_MAPPINGS = {
  "-" => "___dash___",
  "." => "___dot___",
  "/" => "___slash___",
  "0" => "___zero___",
  "1" => "___one___",
  "2" => "___two___",
  "3" => "___three___",
  "4" => "___four___",
  "5" => "___five___",
  "6" => "___six___",
  "7" => "___seven___",
  "8" => "___eight___",
  "9" => "___nine___",
}.freeze
SAFE_TO_UNSAFE_STRING_MAPPINGS = {
  "___dash___" => "-",
  "___dot___" => ".",
  "___slash___" => "/",
  "___zero___" => "0",
  "___one___" => "1",
  "___two___" => "2",
  "___three___" => "3",
  "___four___" => "4",
  "___five___" => "5",
  "___six___" => "6",
  "___seven___" => "7",
  "___eight___" => "8",
  "___nine___" => "9",
}.freeze

# See https://github.com/franklsf95/ruby-emoji-regex
# rubocop:disable Layout/LineLength
EMOJI_REGEX = /[\u{00A9}\u{00AE}\u{203C}\u{2049}\u{2122}\u{2139}\u{2194}-\u{2199}\u{21A9}-\u{21AA}\u{231A}-\u{231B}\u{2328}\u{23CF}\u{23E9}-\u{23F3}\u{23F8}-\u{23FA}\u{24C2}\u{25AA}-\u{25AB}\u{25B6}\u{25C0}\u{25FB}-\u{25FE}\u{2600}-\u{2604}\u{260E}\u{2611}\u{2614}-\u{2615}\u{2618}\u{261D}\u{2620}\u{2622}-\u{2623}\u{2626}\u{262A}\u{262E}-\u{262F}\u{2638}-\u{263A}\u{2640}\u{2642}\u{2648}-\u{2653}\u{2660}\u{2663}\u{2665}-\u{2666}\u{2668}\u{267B}\u{267F}\u{2692}-\u{2697}\u{2699}\u{269B}-\u{269C}\u{26A0}-\u{26A1}\u{26AA}-\u{26AB}\u{26B0}-\u{26B1}\u{26BD}-\u{26BE}\u{26C4}-\u{26C5}\u{26C8}\u{26CE}-\u{26CF}\u{26D1}\u{26D3}-\u{26D4}\u{26E9}-\u{26EA}\u{26F0}-\u{26F5}\u{26F7}-\u{26FA}\u{26FD}\u{2702}\u{2705}\u{2708}-\u{270D}\u{270F}\u{2712}\u{2714}\u{2716}\u{271D}\u{2721}\u{2728}\u{2733}-\u{2734}\u{2744}\u{2747}\u{274C}\u{274E}\u{2753}-\u{2755}\u{2757}\u{2763}-\u{2764}\u{2795}-\u{2797}\u{27A1}\u{27B0}\u{27BF}\u{2934}-\u{2935}\u{2B05}-\u{2B07}\u{2B1B}-\u{2B1C}\u{2B50}\u{2B55}\u{3030}\u{303D}\u{3297}\u{3299}\u{1F004}\u{1F0CF}\u{1F170}-\u{1F171}\u{1F17E}-\u{1F17F}\u{1F18E}\u{1F191}-\u{1F19A}\u{1F1E6}-\u{1F1FF}\u{1F201}-\u{1F202}\u{1F21A}\u{1F22F}\u{1F232}-\u{1F23A}\u{1F250}-\u{1F251}\u{1F300}-\u{1F321}\u{1F324}-\u{1F393}\u{1F396}-\u{1F397}\u{1F399}-\u{1F39B}\u{1F39E}-\u{1F3F0}\u{1F3F3}-\u{1F3F5}\u{1F3F7}-\u{1F4FD}\u{1F4FF}-\u{1F53D}\u{1F549}-\u{1F54E}\u{1F550}-\u{1F567}\u{1F56F}-\u{1F570}\u{1F573}-\u{1F57A}\u{1F587}\u{1F58A}-\u{1F58D}\u{1F590}\u{1F595}-\u{1F596}\u{1F5A4}-\u{1F5A5}\u{1F5A8}\u{1F5B1}-\u{1F5B2}\u{1F5BC}\u{1F5C2}-\u{1F5C4}\u{1F5D1}-\u{1F5D3}\u{1F5DC}-\u{1F5DE}\u{1F5E1}\u{1F5E3}\u{1F5E8}\u{1F5EF}\u{1F5F3}\u{1F5FA}-\u{1F64F}\u{1F680}-\u{1F6C5}\u{1F6CB}-\u{1F6D2}\u{1F6E0}-\u{1F6E5}\u{1F6E9}\u{1F6EB}-\u{1F6EC}\u{1F6F0}\u{1F6F3}-\u{1F6F8}\u{1F910}-\u{1F93A}\u{1F93C}-\u{1F93E}\u{1F940}-\u{1F945}\u{1F947}-\u{1F94C}\u{1F950}-\u{1F96B}\u{1F980}-\u{1F997}\u{1F9C0}\u{1F9D0}-\u{1F9E6}\u{200D}\u{20E3}\u{FE0F}\u{E0020}-\u{E007F}\u{2388}\u{2605}\u{2607}-\u{260D}\u{260F}-\u{2610}\u{2612}\u{2616}-\u{2617}\u{2619}-\u{261C}\u{261E}-\u{261F}\u{2621}\u{2624}-\u{2625}\u{2627}-\u{2629}\u{262B}-\u{262D}\u{2630}-\u{2637}\u{263B}-\u{263F}\u{2641}\u{2643}-\u{2647}\u{2654}-\u{265F}\u{2661}-\u{2662}\u{2664}\u{2667}\u{2669}-\u{267A}\u{267C}-\u{267E}\u{2680}-\u{2691}\u{2698}\u{269A}\u{269D}-\u{269F}\u{26A2}-\u{26A9}\u{26AC}-\u{26AF}\u{26B2}-\u{26BC}\u{26BF}-\u{26C3}\u{26C6}-\u{26C7}\u{26C9}-\u{26CD}\u{26D0}\u{26D2}\u{26D5}-\u{26E8}\u{26EB}-\u{26EF}\u{26F6}\u{26FB}-\u{26FC}\u{26FE}-\u{2701}\u{2703}-\u{2704}\u{270E}\u{2710}-\u{2711}\u{2765}-\u{2767}\u{1F000}-\u{1F003}\u{1F005}-\u{1F0CE}\u{1F0D0}-\u{1F0FF}\u{1F10D}-\u{1F10F}\u{1F12F}\u{1F16C}-\u{1F16F}\u{1F1AD}-\u{1F1E5}\u{1F203}-\u{1F20F}\u{1F23C}-\u{1F23F}\u{1F249}-\u{1F24F}\u{1F252}-\u{1F2FF}\u{1F322}-\u{1F323}\u{1F394}-\u{1F395}\u{1F398}\u{1F39C}-\u{1F39D}\u{1F3F1}-\u{1F3F2}\u{1F3F6}\u{1F4FE}\u{1F53E}-\u{1F548}\u{1F54F}\u{1F568}-\u{1F56E}\u{1F571}-\u{1F572}\u{1F57B}-\u{1F586}\u{1F588}-\u{1F589}\u{1F58E}-\u{1F58F}\u{1F591}-\u{1F594}\u{1F597}-\u{1F5A3}\u{1F5A6}-\u{1F5A7}\u{1F5A9}-\u{1F5B0}\u{1F5B3}-\u{1F5BB}\u{1F5BD}-\u{1F5C1}\u{1F5C5}-\u{1F5D0}\u{1F5D4}-\u{1F5DB}\u{1F5DF}-\u{1F5E0}\u{1F5E2}\u{1F5E4}-\u{1F5E7}\u{1F5E9}-\u{1F5EE}\u{1F5F0}-\u{1F5F2}\u{1F5F4}-\u{1F5F9}\u{1F6C6}-\u{1F6CA}\u{1F6D3}-\u{1F6DF}\u{1F6E6}-\u{1F6E8}\u{1F6EA}\u{1F6ED}-\u{1F6EF}\u{1F6F1}-\u{1F6F2}\u{1F6F9}-\u{1F6FF}\u{1F774}-\u{1F77F}\u{1F7D5}-\u{1F7FF}\u{1F80C}-\u{1F80F}\u{1F848}-\u{1F84F}\u{1F85A}-\u{1F85F}\u{1F888}-\u{1F88F}\u{1F8AE}-\u{1F90F}\u{1F93F}\u{1F94D}-\u{1F94F}\u{1F96C}-\u{1F97F}\u{1F998}-\u{1F9BF}\u{1F9C1}-\u{1F9CF}]/
# rubocop:enable Layout/LineLength

MAX_BODY_LENGTH = 2_000

class NewOctokit < Octokit::Client
  # rubocop:disable Style/ClassVars

  @@repos = {} unless defined? @@repos
  @@users = {} unless defined? @@users
  @@repo_request_count = 0 unless defined? @@repo_request_count
  @@user_request_count = 0 unless defined? @@user_request_count
  @@messages = [] unless defined? @@messages

  def repos
    @@repos
  end

  def users
    @@users
  end

  def messages
    @@messages
  end

  def repo_request_count
    @@repo_request_count
  end

  def user_request_count
    @@user_request_count
  end

  def repository(item)
    return repos[item] if repos.key?(item)

    @@repo_request_count += 1
    repos[item] = super
  rescue Octokit::TooManyRequests
    repos[:skip_requests] = true
    repos[item] = true
  end

  def user(item)
    return users[item] if users.key?(item)

    @@user_request_count += 1
    users[item] = super
  rescue Octokit::TooManyRequests
    users[:skip_requests] = true
    users[item] = true
  end

  def self.repos_skipped?
    @@repos[:skip_requests] ? true : false
  end

  def self.users_skipped?
    @@users[:skip_requests] ? true : false
  end

  def self.repo_request_count
    @@repo_request_count
  end

  def self.user_request_count
    @@user_request_count
  end

  def self.messages
    @@messages
  end

  # rubocop:enable Style/ClassVars
end

def client
  @client ||= NewOctokit.new(access_token: ENV.fetch("GITHUB_TOKEN"))
end

def graphql_query(query)
  jsonified_query = { query: }.to_json
  client.post(GRAPHQL_ENDPOINT, jsonified_query).data
end

def cache_users_exist_check!(user_logins)
  results = graphql_query(graphql_query_string_for_user_logins(user_logins))
  return unless results

  results.each do |login, result|
    converted_back_login = convert_from_query_safe_to_real(login)
    client.users[converted_back_login] = result
  end
end

def cache_orgs_exist_check!(user_logins)
  results = graphql_query(graphql_query_string_for_org_logins(user_logins))
  return unless results

  results.each do |login, result|
    converted_back_login = convert_from_query_safe_to_real(login)
    client.users[converted_back_login] = result
  end
end

def cache_repos_exist_check!(repos)
  results = graphql_query(graphql_query_string_for_repos(repos))
  return unless results

  results.each do |repo, result|
    converted_back_repo_and_name = convert_from_query_safe_to_real(repo)
    client.repos[converted_back_repo_and_name] = result
  end
end

def users_not_found_from(logins)
  logins.select { |login| client.users[login].nil? }
end

def graphql_query_string_for_user_logins(logins)
  query_parts = logins.map do |login|
    key = convert_from_real_to_query_safe(login)
    "#{key}: user(login: \"#{login}\") { login }"
  end

  [
    "query {",
    query_parts.join(" "),
    "}",
  ].join(" ")
end

def graphql_query_string_for_org_logins(logins)
  query_parts = logins.map do |login|
    key = convert_from_real_to_query_safe(login)
    "#{key}: organization(login: \"#{login}\") { login }"
  end

  [
    "query {",
    query_parts.join(" "),
    "}",
  ].join(" ")
end

def graphql_query_string_for_repos(repos)
  query_parts = repos.map do |repo|
    key = convert_from_real_to_query_safe(repo)
    owner, name = repo.split("/")
    "#{key}: repository(owner: \"#{owner}\", name: \"#{name}\") { full_name: nameWithOwner }"
  end

  [
    "query {",
    query_parts.join(" "),
    "}",
  ].join(" ")
end

def existing_explore_feed
  @existing_explore_feed ||= JSON.parse(HTTParty.get(EXPLORE_FEED_URL).body)
end

def existing_collection(name)
  @_existing_collections ||= {}

  @_existing_collections[name] ||= existing_explore_feed["collections"].find do |collection|
    collection["name"] == name
  end
end

def valid_uri_scheme?(scheme)
  return false unless scheme

  %w[http https].include?(scheme.downcase)
end

def metadata_for(dir, name)
  path = File.join(dir, name, "index.md")
  return unless File.file?(path)

  parts = File.read(path).split("---", 3)
  return unless parts.size >= 2

  begin
    YAML.safe_load(parts[1])
  rescue Psych::SyntaxError => error
    flunk "invalid YAML: #{error.message}"
  end
end

def body_for(dir, name)
  path = File.join(dir, name, "index.md")
  return "" unless File.file?(path)

  parts = File.read(path).split("---", 3)
  return "" unless parts.size >= 2

  parts[2]
end

def convert_from_real_to_query_safe(string)
  duplicate = string.dup.to_s

  UNSAFE_TO_SAFE_STRING_MAPPINGS.keys.each_with_object(duplicate) do |key, new_string|
    new_string.gsub(key, UNSAFE_TO_SAFE_STRING_MAPPINGS[key])
  end
end

def convert_from_query_safe_to_real(string)
  duplicate = string.dup.to_s

  SAFE_TO_UNSAFE_STRING_MAPPINGS.keys.each_with_object(duplicate) do |key, new_string|
    new_string.gsub(key, SAFE_TO_UNSAFE_STRING_MAPPINGS[key])
  end
end

def add_message(type, file, line_number, message)
  client.messages << "::#{type} file=#{file},line=#{line_number}::#{message}"
end

Minitest.after_run do
  warn "Repo checks were rate limited during this CI run" if NewOctokit.repos_skipped?
  warn "User checks were rate limited during this CI run" if NewOctokit.users_skipped?
  warn "Repo api was called #{NewOctokit.repo_request_count} times!"
  warn "User api was called #{NewOctokit.user_request_count} times!"

  NewOctokit.messages.each do |message|
    puts message
  end
end
