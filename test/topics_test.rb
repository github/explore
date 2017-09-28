require_relative "./test_helper"

describe "topics" do
  topics.each do |topic|
    describe "#{topic} topic" do
      it "has an index.md" do
        path = File.join(topics_dir, topic, "index.md")

        assert File.file?(path), "expected #{path} to be a file"
      end

      it "has at most one image with the right name and dimensions" do
        paths = image_paths_for(topic)

        assert paths.size <= 1, "expected at most one image, found #{paths.size}"

        if path = paths.first
          assert_equal topic, File.basename(path, File.extname(path)),
            "expected image to be named [topic].[extension]"

          img = Magick::Image.ping(path).first
          assert_equal IMAGE_WIDTH, img.columns, "topic images should be #{IMAGE_WIDTH}px wide"
          assert_equal IMAGE_HEIGHT, img.rows, "topic images should be #{IMAGE_HEIGHT}px tall"
          assert img.filesize < MAX_IMAGE_FILESIZE_IN_BYTES,
            "topic images should not exceed #{MAX_IMAGE_FILESIZE_IN_BYTES} bytes, got " +
            "#{img.filesize} bytes"
        end
      end

      it "has no unexpected files or directories" do
        files = Dir["#{topics_dir}/#{topic}/**/*"].reject do |entry|
          file_name = File.basename(entry)
          image_files = possible_image_file_names_for(topic)

          entry == "." || entry == ".." || file_name == "index.md" ||
            image_files.include?(file_name)
        end

        assert_empty files, "expected only index.md and a single image"
      end

      it "has Jekyll front matter in index.md" do
        path = File.join(topics_dir, topic, "index.md")

        if File.file?(path)
          lines = File.readlines(path)

          assert lines.size > 0
          assert_equal "---\n", lines[0], "expected file to start with Jekyll front matter ---"

          end_index = lines.slice(1..-1).index("---\n")
          assert end_index, "expected Jekyll front matter to end with ---"
        end
      end

      it "has expected metadata in Jekyll front matter" do
        metadata = metadata_for(topic)
        refute_empty metadata, "expected some metadata for topic"

        metadata.each do |key, value|
          assert_includes VALID_METADATA_KEYS, key, "unexpected metadata key '#{key}'"
        end

        REQUIRED_METADATA_KEYS.each do |key|
          assert metadata.key?(key), "expected to have '#{key}' defined for topic"
          assert metadata[key] && metadata[key].strip.size > 0,
            "expected to have a value for '#{key}'"
        end
      end
    end
  end
end
