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
        invalid_slugs = []

        items_for_collection(collection).each do |item|
          URI.parse(item)
        rescue URI::InvalidURIError
          invalid_slugs << item
        end

        assert_empty invalid_slugs, "Invalid item slugs #{invalid_slugs}"
      end

      it "has valid number of items" do
        items = items_for_collection(collection)
        assert (1...MAX_COLLECTION_ITEMS_LENGTH + 1).cover?(items.length),
               "must have no more than #{MAX_COLLECTION_ITEMS_LENGTH} items " \
               "(currently #{items.length})"
      end

      it "fails if a repository does not exist or is private" do
        errors = []

        items_for_collection(collection).each do |item|
          next unless item.match?(USERNAME_AND_REPO_REGEX)

          unless repository_exists?(item)
            errors << "#{collection}: #{item} does not exist or is private"
          end
        end

        assert_empty errors
      end

      it "fails if a user or organization does not exist" do
        errors = []

        items_for_collection(collection).each do |item|
          next unless item.match?(USERNAME_REGEX)

          errors << "#{collection}: #{item} does not exist" unless user_exists?(item)
        end

        assert_empty errors
      end

      it "fails if a user, organization, or repository has been renamed" do
        errors = []

        items_for_collection(collection).each do |item|
          next unless item.match?(USERNAME_AND_REPO_REGEX) || item.match?(USERNAME_REGEX)

          if item.match?(USERNAME_AND_REPO_REGEX)
            errors << "#{collection}: #{item} has been renamed" unless repository_exists?(item)
          else
            errors << "#{collection}: #{item} has been renamed" unless user_exists?(item)
          end
        end

        assert_empty errors
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

        assert_empty files, "expected only index.md and valid images"
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
          metadata_value = metadata[key].is_a?(Array) ? metadata[key] : [metadata[key]]
          assert !metadata_value.empty? &&
                 metadata_value.all? { |value| value&.strip&.size&.positive? },
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

      it "has a valid display name" do
        metadata = metadata_for(collections_dir, collection) || {}
        display_name = metadata["display_name"]

        assert display_name, "must have a value for display name"
        assert display_name.length <= MAX_COLLECTION_DISPLAY_NAME_LENGTH,
               "must have a display name no more than " \
               "#{MAX_COLLECTION_DISPLAY_NAME_LENGTH} characters " \
               "(currently #{display_name.length})"
      end

      it "has valid created_by value" do
        metadata = metadata_for(collections_dir, collection) || {}
        created_by = metadata["created_by"]

        if created_by
          assert created_by.match(USERNAME_REGEX),
                 "#{created_by} may only contain alphanumeric characters or single hyphens, " \
                 "and cannot begin or end with a hyphen"
        end
      end
    end
  end

  def repository_exists?(item)
    client.repository?(item)
  end

  def user_exists?(item)
    client.user(item)
  end
end
