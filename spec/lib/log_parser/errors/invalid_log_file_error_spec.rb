# frozen_string_literal: true

require 'spec_helper'

require 'log_parser/errors/invalid_log_file_error'

RSpec.describe LogParser::Errors::InvalidLogFileError do
  it 'returns useful message' do
    filename = 'some-file.name'
    error = LogParser::Errors::InvalidLogFileError.new(filename)

    expect(error.message).to eq(<<~MSG.chomp)
      this file '#{filename}' is not a valid log file
    MSG
  end
end
