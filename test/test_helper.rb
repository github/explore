require "minitest/autorun"
require "fastimage"
require "yaml"

IMAGE_EXTENSIONS = %w[.jpg .jpeg .png].freeze
IMAGE_WIDTH = 288
IMAGE_HEIGHT = 288
MAX_IMAGE_FILESIZE_IN_BYTES = 65_000
VALID_METADATA_KEYS = %w[aliases created_by display_name github_url logo related
                         released short_description topic url wikipedia_url].freeze
REQUIRED_METADATA_KEYS = %w[topic short_description].freeze

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

def body_for(topic)
  path = File.join(topics_dir, topic, "index.md")
  return "" unless File.file?(path)

  parts = File.read(path).split("---", 3)
  return "" unless parts.size >= 2

  parts[2]
end
