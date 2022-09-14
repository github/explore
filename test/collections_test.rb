require_relative "./collections_test_helper"

describe "collections" do
  collections.each do |collection|
    describe "#{collection} collection" do
      unless ENV["AUTOCORRECT_RENAMED_REPOS"] == "1"
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
                              "should not specify image #{metadata['image']} when file does not "\
                                "exist"
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

      it "fails if a user, organization, or repository has been renamed or removed" do
        errors = []
        repos_to_check = []
        users_to_check = []

        items_for_collection(collection).each do |item|
          next unless item.match?(USERNAME_AND_REPO_REGEX) || item.match?(USERNAME_REGEX)

          if item.match?(USERNAME_AND_REPO_REGEX)
            repos_to_check << item
          else
            users_to_check << item
          end
        end

        cache_repos_exist_check!(repos_to_check)
        cache_users_exist_check!(users_to_check)
        cache_orgs_exist_check!(users_not_found_from(users_to_check))

        repos_to_check.each do |repo|
          repo_result = client.repository(repo)
          current_name_with_owner = repo_result&.full_name

          if repo_result.nil?
            if ENV["AUTOCORRECT_RENAMED_REPOS"] == "1"
              remove_collection_item(collection, repo)
            else
              error_message = "#{collection}: #{repo} does not exist or has been made private"
              annotate_collection_item_error(collection, repo, error_message)
              errors << error_message
            end
          elsif current_name_with_owner != repo
            if ENV["AUTOCORRECT_RENAMED_REPOS"] == "1"
              update_collection_item(collection, repo, current_name_with_owner)
            else
              error_message =
                "#{collection}: #{repo} has been renamed to #{current_name_with_owner}"
              annotate_collection_item_error(collection, repo, error_message)
              errors << error_message
            end
          end
        end

        users_to_check.each do |login|
          user_result = client.user(login)
          current_login = user_result&.login

          if user_result.nil?
            error_message = "#{collection}: #{login} does not exist"
            annotate_collection_item_error(collection, login, error_message)
            errors << error_message
          elsif current_login != login
            error_message = "#{collection}: #{login} has been renamed to #{current_login}"
            annotate_collection_item_error(collection, login, error_message)
            errors << error_message
          end
        end

        assert_empty errors unless ENV["AUTOCORRECT_RENAMED_REPOS"] == "1"
      end
    end

    next if ENV["AUTOCORRECT_RENAMED_REPOS"] == "1"

    it "has the same order and new items are at the end" do
      collection_items = items_for_collection(collection)
      existing_items = existing_items_for_collection(collection)
      errors = []

      collection_items_minus_new_additions = collection_items[0, existing_items.length]

      if collection_items_minus_new_additions != existing_items
        errors << "expected collection changes to have been appended to the existing item list"
        annotate_collection_item_error(collection, "", errors.join("\n"))
      end

      assert_empty errors
    end
  end

  def existing_items_for_collection(collection)
    existing_collection(collection)&.[]("items") || []
  end
end
