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
