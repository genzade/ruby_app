# frozen_string_literal: true

module FileFixtureHelper
  def fixture_path
    File.expand_path(File.join('../../fixtures'), __dir__)
  end

  def fixture(file)
    fixture_file_path = "#{fixture_path}/#{file}"
    fail_msg = "#{fixture_file_path} does not exist: add it to #{fixture_path}"

    raise fail_msg unless File.exist?(fixture_file_path)

    File.expand_path("#{fixture_path}/#{file}")
  end
end

RSpec.configure do |config|
  config.include FileFixtureHelper
end
