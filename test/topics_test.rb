require_relative "./test_helper"

describe "topics" do
  topics.each do |topic|
    describe "#{topic} topic" do
      it "has an index.md" do
        path = File.join(topics_dir, topic, "index.md")

        assert File.file?(path), "expected #{path} to be a file"
      end

      it "has only one image with the right name" do
        paths = image_paths_for(topic)

        assert paths.size <= 1, "expected at most one image, found #{paths.size}"

        if path = paths.first
          assert_equal topic, File.basename(path, File.extname(path)),
            "expected image to be named [topic].[extension]"
        end
      end
    end
  end
end
