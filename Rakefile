require "rake/testtask"

Rake::TestTask.new(:topics) do |t|
  t.libs << "test"
  t.test_files = FileList["test/topics_test.rb"]
  t.warning = false
  t.verbose = false
end

Rake::TestTask.new(:collections) do |t|
  t.libs << "test"
  t.test_files = FileList["test/collections_test.rb"]
  t.warning = false
  t.verbose = false
end

Rake::TestTask.new(:default) do |t|
  t.libs << "test"
  t.test_files = FileList["test/*_test.rb"]
  t.warning = false
  t.verbose = false
end

desc "Run topics related tests"
task topics: :test

desc "Run collections related tests"
task collections: :test

desc "Run all tests"
task default: :test
task all: :default
