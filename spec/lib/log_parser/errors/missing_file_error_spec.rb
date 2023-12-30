# frozen_string_literal: true

require 'spec_helper'

require 'log_parser/errors/missing_file_error'

RSpec.describe LogParser::Errors::MissingFileError do
  it 'returns useful message' do
    filename = 'some-file.name'
    error = LogParser::Errors::MissingFileError.new(filename)

    expect(error.message).to eq(<<~MSG.chomp)
      this file '#{filename}' does not exist
    MSG
  end
end
