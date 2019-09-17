require_relative "./test_helper"

VALID_TOPIC_METADATA_KEYS = %w[aliases created_by display_name github_url logo related
                               released short_description topic url wikipedia_url].freeze
REQUIRED_TOPIC_METADATA_KEYS = %w[topic short_description].freeze
ENGLISH_MONTHS = %w[January February March April May June July August September October November
                    December].freeze

TOPIC_IMAGE_EXTENSIONS = %w[.jpg .jpeg .png].freeze

MAX_TOPIC_LENGTH = 35

MAX_ALIAS_COUNT = 120

MAX_RELATED_TOPIC_COUNT = 10

MAX_SHORT_DESCRIPTION_LENGTH = 130

TOPIC_REGEX = /\A[a-z0-9][a-z0-9-]*\Z/.freeze

def invalid_topic_message(topic)
  "'#{topic}' must be between 1-#{MAX_TOPIC_LENGTH} characters, start with a letter or number, " \
    "include only lowercase letters, and may include hyphens"
end

def valid_topic?(raw_topic)
  return false unless raw_topic

  topic = raw_topic.strip
  return false if topic.length > MAX_TOPIC_LENGTH
  return false unless topic.match?(TOPIC_REGEX)

  !topic.empty?
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
    File.file?(entry) && TOPIC_IMAGE_EXTENSIONS.include?(File.extname(entry).downcase)
  end
end

def possible_image_file_names_for(topic)
  TOPIC_IMAGE_EXTENSIONS.map { |ext| "#{topic}#{ext}" }
end

def related_topics_for(topic)
  metadata = metadata_for(topics_dir, topic)
  return [] unless metadata
  return [] unless metadata["related"]

  metadata["related"].split(",")
end

def aliases_for(topic)
  metadata = metadata_for(topics_dir, topic)
  return [] unless metadata
  return [] unless metadata["aliases"]

  metadata["aliases"].split(",")
end

def assert_oxford_comma(text)
  return unless text

  text.delete("\n").split(".").each do |sentence|
    # This is arbitrary; 2 is more correct but 3 avoids false positives.
    next if sentence.count(",") < 3

    %w[and or].each do |conjunction|
      next unless sentence.include? " #{conjunction} "

      assert_includes sentence, ", #{conjunction}", "Always use the Oxford comma"
    end
  end
end
