require_relative "./collections_test_helper"

describe "collections" do
  collections.each do |collection|
    describe "#{collection} collection" do
      it "has a valid name" do
        assert valid_collection?(collection), invalid_collection_message(collection)
      end

      it "does not include emoji outside of description" do
        metadata = metadata_for(collections_dir, collection) || {}

        fields = %w[created_by display_name collection]
        fields.each do |field|
          if value = metadata[field].to_s
            assert value == value.gsub(EMOJI_REGEX, ""),
                   "#{field} should not include emoji:\n\t#{value}"
          end
        end
      end

      it "has valid items" do
        metadata = metadata_for(collections_dir, collection) || {}
        items = metadata["items"]
        invalid_slugs = []
        items.each do |item|
          begin
            URI.parse(item)
          rescue URI::InvalidURIError
            invalid_slugs << item
          end
        end
        assert_empty invalid_slugs, "Invalid item slugs #{invalid_slugs}"
      end

      it "has an index.md" do
        path = File.join(collections_dir, collection, "index.md")

        assert File.file?(path), "expected #{path} to be a file"
      end

      it "has no unexpected files or directories" do
        image_files = possible_image_file_names_for_collection(collection)
        files = Dir["#{collections_dir}/#{collection}/**/*"].reject do |entry|
          file_name = File.basename(entry)
          entry == "." || entry == ".." || file_name == "index.md" ||
            image_files.include?(file_name)
        end

        assert_empty files, "expected only index.md and a single image"
      end

      it "has Jekyll front matter in index.md" do
        path = File.join(collections_dir, collection, "index.md")

        if File.file?(path)
          lines = File.readlines(path)

          refute lines.empty?
          assert_equal "---\n", lines[0], "expected file to start with Jekyll front matter ---"

          end_index = lines.slice(1..-1).index("---\n")
          assert end_index, "expected Jekyll front matter to end with ---"
        end
      end

      it "has expected metadata in Jekyll front matter" do
        metadata = metadata_for(collections_dir, collection)
        refute_empty metadata, "expected some metadata for collection"

        metadata.each_key do |key|
          assert_includes VALID_COLLECTION_METADATA_KEYS, key, "unexpected metadata key '#{key}'"
        end

        REQUIRED_COLLECTION_METADATA_KEYS.each do |key|
          assert metadata.key?(key), "expected to have '#{key}' defined for collection"
          assert metadata[key]&.strip&.size&.positive?,
                 "expected to have a value for '#{key}'"
        end
      end

      it "uses the right file name for specified image" do
        metadata = metadata_for(collections_dir, collection)

        if metadata
          paths = image_paths_for_collection(collection)
          valid_file_names = paths.map { |path| File.basename(path) }
          error_message = if valid_file_names.empty?
                            "should not specify image #{metadata['image']} when file does not exist"
                          else
                            "image should be #{valid_file_names.join(' or ')}, but was " +
                              metadata["image"].to_s
                          end
          assert !metadata.key?("image") || valid_file_names.include?(metadata["image"]),
                 error_message
        end
      end

      it "has a valid body" do
        body = body_for(collections_dir, collection)

        assert body && (1...MAX_BODY_LENGTH).cover?(body.length),
               "must have a body no more than #{MAX_BODY_LENGTH} characters " \
               "(currently #{body.length})"
      end

      it "has valid created_by value" do
        metadata = metadata_for(collections_dir, collection) || {}

        if metadata["created_by"]
          assert metadata["created_by"].match(USERNAME_REGEX),
                 "may only contain alphanumeric characters or single hyphens, " \
                 "and cannot begin or end with a hyphen"
        end
      end
    end
  end
end
