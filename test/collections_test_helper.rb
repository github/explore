# rubocop:disable Metrics/LineLength
require_relative "./test_helper"

VALID_COLLECTION_METADATA_KEYS = %w[collection created_by display_name image items].freeze

REQUIRED_COLLECTION_METADATA_KEYS = %w[display_name].freeze

MAX_COLLECTION_LENGTH = 40

COLLECTION_IMAGE_EXTENSIONS = %w[.jpg .jpeg .png .gif].freeze

COLLECTION_REGEX = /\A[a-z0-9][a-z0-9-]*\Z/

USERNAME_REGEX = /\A[a-z0-9]+(-[a-z0-9]+)*\z/i

def invalid_collection_message(collection)
  "'#{collection}' must be between 1-#{MAX_COLLECTION_LENGTH} characters, start with a letter or number, " \
    "and may include hyphens"
end

def valid_collection?(raw_collection)
  return false unless raw_collection
  collection = raw_collection.strip
  return false if collection.length > MAX_COLLECTION_LENGTH
  return false unless collection.match?(COLLECTION_REGEX)
  !collection.empty?
end

def collections_dir
  File.expand_path("../collections", File.dirname(__FILE__))
end

def collection_dirs
  Dir["#{collections_dir}/*"].select do |entry|
    entry != "." && entry != ".." && File.directory?(entry)
  end
end

def collections
  collection_dirs.map { |dir_path| File.basename(dir_path) }
end

def image_paths_for_collection(collection)
  Dir["#{collections_dir}/#{collection}/*"].select do |entry|
    File.file?(entry) && COLLECTION_IMAGE_EXTENSIONS.include?(File.extname(entry).downcase)
  end
end

def possible_image_file_names_for_collection(collection)
  COLLECTION_IMAGE_EXTENSIONS.map { |ext| "#{collection}#{ext}" }
end

def metadata_for_collection(collection)
  path = File.join(collections_dir, collection, "index.md")
  return unless File.file?(path)

  parts = File.read(path).split("---", 3)
  return unless parts.size >= 2

  begin
    YAML.safe_load(parts[1])
  rescue Psych::SyntaxError => ex
    flunk "invalid YAML: #{ex.message}"
  end
end

def body_for_collection(collection)
  path = File.join(collections_dir, collection, "index.md")
  return "" unless File.file?(path)

  parts = File.read(path).split("---", 3)
  return "" unless parts.size >= 2

  parts[2]
end
