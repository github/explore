require "minitest/autorun"
require "yaml"

IMAGE_EXTENSIONS = %w[.jpg .jpeg .png].freeze

VALID_METADATA_KEYS = %w[aliases created_by display_name github_url logo related
                         released short_description topic url wikipedia_url].freeze

REQUIRED_METADATA_KEYS = %w[topic short_description].freeze

MAX_TOPIC_LENGTH = 35

MAX_ALIAS_COUNT = 10

MAX_RELATED_TOPIC_COUNT = 10

TOPIC_REGEX = /\A[a-z0-9][a-z0-9-]*\Z/

def invalid_topic_message(topic)
  "'#{topic}' must be between 1-#{MAX_TOPIC_LENGTH} characters, start with a letter or number, " \
    "and may include hyphens"
end

def valid_topic?(raw_topic)
  return false unless raw_topic
  normalized_topic = raw_topic.gsub(/\A[[:space:]]+/, "")
                              .gsub(/[[:space:]]+\z/, "")
                              .gsub(/[[:space:]]+/, " ")
                              .downcase
                              .tr(" ", "-")
                              .tr("_", "-")
  return false if normalized_topic.length > MAX_TOPIC_LENGTH
  return false unless normalized_topic.match?(TOPIC_REGEX)
  !normalized_topic.empty?
end

def topics_dir
  File.expand_path("../topics", File.dirname(__FILE__))
end

def topic_dirs
  Dir["#{topics_dir}/*"].select do |entry|
    entry != "." && entry != ".." && File.directory?(entry)
  end
end

def topics
  topic_dirs.map { |dir_path| File.basename(dir_path) }
end

def image_paths_for(topic)
  Dir["#{topics_dir}/#{topic}/*"].select do |entry|
    File.file?(entry) && IMAGE_EXTENSIONS.include?(File.extname(entry).downcase)
  end
end

def possible_image_file_names_for(topic)
  IMAGE_EXTENSIONS.map { |ext| "#{topic}#{ext}" }
end

def metadata_for(topic)
  path = File.join(topics_dir, topic, "index.md")
  return unless File.file?(path)

  parts = File.read(path).split("---", 3)
  return unless parts.size >= 2

  begin
    YAML.safe_load(parts[1])
  rescue Psych::SyntaxError => ex
    flunk "invalid YAML: #{ex.message}"
  end
end

def related_topics_for(topic)
  metadata = metadata_for(topic)
  return [] unless metadata
  return [] unless metadata["related"]
  metadata["related"].split(",").map(&:strip)
end

def aliases_for(topic)
  metadata = metadata_for(topic)
  return [] unless metadata
  return [] unless metadata["aliases"]
  metadata["aliases"].split(",").map(&:strip)
end

def body_for(topic)
  path = File.join(topics_dir, topic, "index.md")
  return "" unless File.file?(path)

  parts = File.read(path).split("---", 3)
  return "" unless parts.size >= 2

  parts[2]
end
