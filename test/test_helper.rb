require "minitest/autorun"
require "yaml"

IMAGE_EXTENSIONS = [".jpg", ".jpeg", ".png"].freeze

VALID_METADATA_KEYS = ["aliases", "created_by", "display_name", "github_url", "logo", "related",
                       "released", "short_description", "topic", "url", "wikipedia_url"].freeze

REQUIRED_METADATA_KEYS = ["topic", "short_description"].freeze

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

  metadata = begin
    YAML.load(parts[1])
  rescue Psych::SyntaxError => ex
    flunk "invalid YAML: #{ex.message}"
  end
end
