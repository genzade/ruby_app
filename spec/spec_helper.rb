# frozen_string_literal: true

Dir.glob(::File.expand_path('support/**/*.rb', __dir__)).each { |f| require_relative f }

def parser_bin
  File.expand_path('../exe/parser', __dir__)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  config.disable_monkey_patching!
  config.order = :random
end
