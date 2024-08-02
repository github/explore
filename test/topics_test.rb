require_relative "./topics_test_helper"

describe "topics" do
  # Used by the Topics Page Style Guide test
  end_punctuation = %w[. , ; :] + [" "]
  month_abbreviations = %w[Jan Feb Mar Apr Jun Jul Aug Sep Oct Nov Dec]
  git_verbs = %w[GitHubbing Gitting]
  bad_github_variants = %w[Github github]

  topics.each do |topic|
    describe "#{topic} topic" do
      it "has a valid name" do
        assert valid_topic?(topic), invalid_topic_message(topic)
      end

      it "does not have an alias for a topic that has its own curated content" do
        aliases = aliases_for(topic)

        if aliases.any?
          other_topics = topics - [topic]
          aliases_that_have_a_topic = other_topics & aliases
          assert_empty aliases_that_have_a_topic,
                       "alias(es) #{aliases_that_have_a_topic.join(', ')} already have a topic " \
                       "defined, please move to 'related' instead"
        end
      end

      it "does not add an alias that's already in use" do
        aliases = aliases_for(topic)

        if aliases.any?
          other_topics = topics - [topic]
          other_topics.each do |other_topic|
            other_aliases = aliases_for(other_topic)
            shared_aliases = aliases & other_aliases
            verb = shared_aliases.length == 1 ? "is" : "are"

            assert_empty shared_aliases,
                         "#{shared_aliases.join(', ')} #{verb} already aliased to " \
                         "#{other_topic}, please remove from either '#{topic}' or '#{other_topic}'"
          end
        end
      end

      it "uses the right format for 'released'" do
        metadata = metadata_for(topics_dir, topic) || ""

        if released = metadata["released"]
          text = released.to_s.gsub(/[\d+,\s]/, "").strip

          unless text.empty?
            assert_includes ENGLISH_MONTHS, text,
                            "please format 'released' like MONTH DD, YYYY with the month in English"
          end

          ENGLISH_MONTHS.each do |month|
            refute_includes released.to_s, "#{month},",
                            "should not include a comma after the month name"
          end
        end
      end

      it "ends 'released' with a number" do
        metadata = metadata_for(topics_dir, topic) || {}

        if metadata["released"]
          number_regex = /\d\z/
          assert_match number_regex, metadata["released"].to_s.strip,
                       "released should end with a number"
        end
      end

      it "ends 'short_description' with punctuation" do
        metadata = metadata_for(topics_dir, topic) || {}

        if metadata["short_description"]
          punctuation_regex = /[.?!]\z/
          assert_match punctuation_regex, metadata["short_description"],
                       "short_description should end with punctuation"
        end
      end

      it "does not include emoji outside of description" do
        metadata = metadata_for(topics_dir, topic) || {}

        fields = %w[created_by display_name released short_description related aliases topic]
        fields.each do |field|
          if value = metadata[field].to_s
            assert value == value.gsub(EMOJI_REGEX, ""),
                   "#{field} should not include emoji:\n\t#{value}"
          end
        end
      end

      it "has a valid GitHub URL" do
        metadata = metadata_for(topics_dir, topic) || {}

        if (url = metadata["github_url"])
          uri = URI.parse(url)
          assert valid_uri_scheme?(uri.scheme), "github_url should start with http:// or https://"
          regex = /github\.com/
          assert_match regex, uri.host, "github_url #{url} should point to github.com"
        end
      end

      it "has a valid URL" do
        metadata = metadata_for(topics_dir, topic) || {}

        if (url = metadata["url"])
          uri = URI.parse(url)
          assert valid_uri_scheme?(uri.scheme), "url should start with http:// or https://"
          assert uri.host, "url #{url} should have a hostname"
        end
      end

      it "has a valid Wikipedia URL" do
        metadata = metadata_for(topics_dir, topic) || {}

        if (url = metadata["wikipedia_url"])
          uri = URI.parse(url)
          assert valid_uri_scheme?(uri.scheme),
                 "wikipedia_url should start with http:// or https://"
          regex = /wikipedia\.org/
          assert_match regex, uri.host, "wikipedia_url #{url} should point to wikipedia.org"
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
        metadata = metadata_for(topics_dir, topic)

        if metadata
          assert_equal topic, metadata["topic"],
                       "'topic' key should match the directory name '#{topic}'"
        end
      end

      it "has a short_description that differs from the body" do
        metadata = metadata_for(topics_dir, topic) || {}
        body = body_for(topics_dir, topic)

        if metadata["short_description"]
          refute_equal body.strip, metadata["short_description"].strip,
                       "body and short description should differ"
        end
      end

      it "has an index.md" do
        path = File.join(topics_dir, topic, "index.md")

        assert File.file?(path), "expected #{path} to be a file"
      end

      it "has matching logo, when logo key exists" do
        metadata = metadata_for(topics_dir, topic)

        if metadata
          paths = image_paths_for(topic)
          valid_file_names = paths.map { |path| File.basename(path) }

          if metadata["logo"]
            assert valid_file_names.include?(metadata["logo"]),
                   "should not specify logo #{metadata['logo']} when file does not exist"
          end
        end
      end

      it "has a matching logo key, when logo exists" do
        metadata = metadata_for(topics_dir, topic)

        if metadata
          paths = image_paths_for(topic)
          valid_file_names = paths.map { |path| File.basename(path) }

          if valid_file_names.any?
            assert valid_file_names.include?(metadata["logo"]),
                   "logo key should be #{valid_file_names.join(' or ')}, but was "\
                   "#{metadata['logo'].nil? ? 'missing' : metadata['logo']}"
          end
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

          assert_includes TOPIC_IMAGE_EXTENSIONS, ".#{FastImage.type(path)}",
                          "topic images should be one of #{TOPIC_IMAGE_EXTENSIONS.join(', ')}"

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
          assert_includes ["---\n", "---\r", "---\r\n"], lines[0],
                          "expected file to start with Jekyll front matter ---"

          all_lines = lines.slice(1..-1)
          end_index = all_lines.index("---\n") ||
                      all_lines.index("---\r") ||
                      all_lines.index("---\r\n")
          assert end_index, "expected Jekyll front matter to end with ---"
        end
      end

      it "has expected metadata in Jekyll front matter" do
        metadata = metadata_for(topics_dir, topic)
        refute_empty metadata, "expected some metadata for topic"

        metadata.each_key do |key|
          assert_includes VALID_TOPIC_METADATA_KEYS, key, "unexpected metadata key '#{key}'"
        end

        REQUIRED_TOPIC_METADATA_KEYS.each do |key|
          assert metadata.key?(key), "expected to have '#{key}' defined for topic"
          assert metadata[key]&.strip&.size&.positive?,
                 "expected to have a value for '#{key}'"
        end
      end

      it "has a valid body" do
        body = body_for(topics_dir, topic)

        assert body && (1...MAX_BODY_LENGTH).cover?(body.length),
               "must have a body no more than #{MAX_BODY_LENGTH} characters " \
               "(currently #{body.length})"
      end

      it "has a valid short_description" do
        metadata = metadata_for(topics_dir, topic) || {}

        if (short_description = metadata["short_description"])
          valid_range = 1..MAX_SHORT_DESCRIPTION_LENGTH
          current_length = short_description.length
          assert valid_range.cover?(current_length),
                 "must have a short_description no more than #{MAX_SHORT_DESCRIPTION_LENGTH} " \
                 "characters (currently #{current_length})"
        end
      end

      it "has a valid display_name" do
        metadata = metadata_for(topics_dir, topic) || {}

        if (display_name = metadata["display_name"])
          valid_range = 1..MAX_DISPLAY_NAME_LENGTH
          current_length = display_name.length
          assert valid_range.cover?(current_length),
                 "must have a display_name no more than #{MAX_DISPLAY_NAME_LENGTH} " \
                 "characters (currently #{current_length})"
        end
      end

      it "has a valid created_by" do
        metadata = metadata_for(topics_dir, topic) || {}

        if (created_by = metadata["created_by"])
          valid_range = 1..MAX_CREATED_BY_LENGTH
          current_length = created_by.length
          assert valid_range.cover?(current_length),
                 "must have a created_by no more than #{MAX_CREATED_BY_LENGTH} " \
                 "characters (currently #{current_length})"
        end
      end

      it "follows the Topic Page Style Guide" do
        text = body_for(topics_dir, topic)
        metadata = metadata_for(topics_dir, topic)

        text.lines do |line|
          line.chomp!

          refute_includes line, "open-source", "Use open source without a hyphen"

          month_abbreviations.each do |month|
            refute_includes line, "#{month} ", "Include and spell out the month"
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
          end
        end

        # assert_oxford_comma(text)
        if metadata
          assert_oxford_comma(metadata["short_description"])
          assert_oxford_comma(metadata["created_by"])
        end
      end
    end
  end
end
