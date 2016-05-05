require 'simple_mapnik/api'
require 'ffi'

# Check if c api lib exists, and compile if not.
SimpleMapnik::Api.new.check_and_install

# Require all simple mapnik modules. They need the c api lib,
# so this must happen after a check is done and the lib is compiled.
require 'simple_mapnik'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Create a temp directory before running tests.
  config.before(:suite) do
    tmp = File.expand_path(File.join('.', 'tmp'))
    Dir.mkdir(tmp) unless Dir.exist? tmp
  end

  # Delete the temp directory after running tests.
  config.after(:suite) do
    tmp = File.expand_path(File.join('.', 'tmp'))
    FileUtils.rm_rf(tmp) if Dir.exist? tmp
  end
end
