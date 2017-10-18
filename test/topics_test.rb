require_relative "./test_helper"

describe "topics" do
  topics.each do |topic|
    describe "#{topic} topic" do
      it "has a valid name" do
        assert valid_topic?(topic), invalid_topic_message(topic)
      end

      it "has a valid GitHub URL" do
        metadata = metadata_for(topic)

        if metadata && metadata["github_url"]
          uri = URI.parse(metadata["github_url"])
          assert_includes ["www.github.com", "github.com"], uri.host,
            "github_url should point to either www.github.com or github.com"
        end
      end

      it "has a valid Wikipedia URL" do
        metadata = metadata_for(topic)

        if metadata && metadata["wikipedia_url"]
          uri = URI.parse(metadata["wikipedia_url"])
          assert_match /wikipedia\.org/, uri.host, "wikipedia_url should point to wikipedia.org"
        end
      end

      it "has valid aliases" do
        aliases = aliases_for(topic)

        aliases.each do |topic_alias|
          assert valid_topic?(topic_alias), invalid_topic_message(topic_alias)
          refute_equal topic_alias, topic,
                       "alias '#{topic_alias}' must not be the same as the topic"
        end

        assert_equal aliases.size, aliases.uniq.size, "should not duplicate aliases"
        assert aliases.size <= MAX_ALIAS_COUNT,
               "should have no more than #{MAX_ALIAS_COUNT} aliases"
      end

      it "has valid related topics" do
        related_topics = related_topics_for(topic)

        related_topics.each do |related_topic|
          assert valid_topic?(related_topic), invalid_topic_message(related_topic)
          refute_equal related_topic, topic,
                       "related topic '#{related_topic}' must not be the same as the topic"
        end

        assert_equal related_topics.size, related_topics.uniq.size,
                     "should not duplicate related topics"
        assert related_topics.size <= MAX_RELATED_TOPIC_COUNT,
               "should have no more than #{MAX_RELATED_TOPIC_COUNT} related topics"
      end

      it "has unique related topics and aliases" do
        aliases = aliases_for(topic)
        related_topics = related_topics_for(topic)

        assert_empty aliases & related_topics,
                     "a topic should only be an alias or a related topic, but not both"
      end

      it "has a matching topic key" do
        metadata = metadata_for(topic)

        if metadata
          assert_equal topic, metadata["topic"],
                       "'topic' key should match the directory name '#{topic}'"
        end
      end

      it "has an index.md" do
        path = File.join(topics_dir, topic, "index.md")

        assert File.file?(path), "expected #{path} to be a file"
      end

      it "does not specify an image if none exists" do
        paths = image_paths_for(topic)
        metadata = metadata_for(topic)
        no_image_exists = paths.all? { |path| !File.exist?(path) }

        if no_image_exists && metadata
          refute_includes metadata.keys, "logo",
                          "should not specify a logo '#{metadata['logo']}' if no image exists"
        end
      end

      it "has at most one image with the right name, type, and dimensions" do
        paths = image_paths_for(topic)

        assert paths.size <= 1, "expected at most one image, found #{paths.size}"

        if path = paths.first
          assert_equal topic, File.basename(path, File.extname(path)),
                       "expected image to be named [topic].[extension]"

          width, height = FastImage.size(path)
          assert_equal IMAGE_WIDTH, width, "topic images should be #{IMAGE_WIDTH}px wide"
          assert_equal IMAGE_HEIGHT, height, "topic images should be #{IMAGE_HEIGHT}px tall"

          assert_includes IMAGE_EXTENSIONS, ".#{FastImage.type(path)}",
                          "topic images should be one of #{IMAGE_EXTENSIONS.join(', ')}"

          file_size = FastImage.new(path).content_length
          assert file_size <= MAX_IMAGE_FILESIZE_IN_BYTES,
                 "topic images should not exceed #{MAX_IMAGE_FILESIZE_IN_BYTES} bytes, got " \
                 "#{file_size} bytes"
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

          refute lines.empty?
          assert_equal "---\n", lines[0], "expected file to start with Jekyll front matter ---"

          end_index = lines.slice(1..-1).index("---\n")
          assert end_index, "expected Jekyll front matter to end with ---"
        end
      end

      it "has expected metadata in Jekyll front matter" do
        metadata = metadata_for(topic)
        refute_empty metadata, "expected some metadata for topic"

        metadata.each_key do |key|
          assert_includes VALID_METADATA_KEYS, key, "unexpected metadata key '#{key}'"
        end

        REQUIRED_METADATA_KEYS.each do |key|
          assert metadata.key?(key), "expected to have '#{key}' defined for topic"
          assert metadata[key]&.strip&.size&.positive?,
                 "expected to have a value for '#{key}'"
        end
      end

      it "follows the Topic Page Style Guide" do
        text = body_for(topic)
        metadata = metadata_for(topic)
        end_punctuation = %w[. , ; :] + [" "]
        month_abbreviations = %w[Jan Feb Mar Apr Jun Jul Aug Sep Oct Nov Dec]
        day_ordinals = %w[1st 2nd 3rd 1th 2th 3th 4th 5th 6th 7th 8th 9th]
        git_verbs = %w[GitHubbing Gitting]
        bad_github_variants = %w[Github github]
        numbers_to_be_spelled_out = 1..9

        text.lines do |line|
          line.chomp!

          refute_includes line, "&", 'Use "and" rather than an ampersand'
          refute_includes line, "!", "Avoid exclamation points in topic pages"
          refute_includes line, "open-source", "Use open source without a hyphen"

          month_abbreviations.each do |month|
            refute_includes line, "#{month} ", "Include and spell out the month"
          end

          day_ordinals.each do |date_end|
            refute_includes line, date_end,
                            'Include the day number without the "th" or "nd" at the end'
          end

          git_verbs.each do |no_git_verb|
            refute_includes line, no_git_verb,
                            "Never use “GitHub” or “Git” as a verb."
          end

          bad_github_variants.each do |wrong_github|
            no_url_line = line.gsub "github.com"
            refute_includes no_url_line, wrong_github,
                            'Always use correct capitalization when referring to "GitHub"'
          end

          end_punctuation.each do |punctuation|
            refute_includes line, "git#{punctuation}",
                            'Always use correct capitalization when referring to "Git"'

            numbers_to_be_spelled_out.each do |digit|
              refute_includes line, " #{digit}#{punctuation}",
                              'Write out "one" and every number less than 10'
            end
          end
        end

        assert_oxford_comma(text)
        if metadata
          assert_oxford_comma(metadata["short_description"])
          assert_oxford_comma(metadata["created_by"])
        end
      end
    end
  end
end
