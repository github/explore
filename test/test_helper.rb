require "minitest/autorun"

def topics_dir
  File.expand_path("../topics", File.dirname(__FILE__))
end

def topic_dirs
  @topic_dirs ||= Dir["#{topics_dir}/*"].select do |entry|
    entry != "." && entry != ".." && File.directory?(entry)
  end
end

def topics
  @topics ||= topic_dirs.map { |dir_path| File.basename(dir_path) }
end

IMAGE_EXTENSIONS = [".jpg", ".jpeg", ".png"]

def image_paths_for(topic)
  Dir["#{topics_dir}/#{topic}/*"].select do |entry|
    File.file?(entry) && IMAGE_EXTENSIONS.include?(File.extname(entry).downcase)
  end
end

def possible_image_file_names_for(topic)
  IMAGE_EXTENSIONS.map { |ext| "#{topic}#{ext}" }
end
