# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'parser', type: :aruba do
  it 'parser file is an executable' do
    expect(parser_bin).to be_an_existing_executable
  end

  context 'when file does not exists' do
    it 'outputs an error message' do
      run_command("#{parser_bin} non-existent.file")

      expect(last_command_started).to have_output_on_stderr(<<~OUTPUT.chomp)
        LogParser::Errors::MissingFileError: this file 'non-existent.file' does not exist
      OUTPUT
    end
  end

  context 'when file is not a valid log file' do
    it 'outputs an error message' do
      cd fixture_path do
        run_command("#{parser_bin} not-a-log.file")
      end

      expect(last_command_started).to have_output_on_stderr(<<~OUTPUT.chomp)
        LogParser::Errors::InvalidLogFileError: this file 'not-a-log.file' is not a valid log file
      OUTPUT
    end
  end

  context 'when file exists' do
    context 'with most page views' do
      it 'outputs list of webpages with most page views order descending' do
        expected_output = <<~OUTPUT.chomp
          /about       ........ 11    visits
          /home        ........ 10    visits
          /contact     ........ 9     visits
          /help_page/1 ........ 8     visits
          /about/2     ........ 7     visits
          /index       ........ 5     visits
        OUTPUT

        cd fixture_path do
          run_command("#{parser_bin} webserver.log")
        end

        expect(last_command_started).to be_successfully_executed
        expect(last_command_started).to have_output(expected_output)
      end
    end

    context 'with uniques page views' do
      it 'outputs list of webpages with most unique page views order descending' do
        expected_output = <<~OUTPUT.chomp
          /about       ........ 9     unique views
          /home        ........ 8     unique views
          /contact     ........ 7     unique views
          /about/2     ........ 6     unique views
          /help_page/1 ........ 6     unique views
          /index       ........ 5     unique views
        OUTPUT

        cd fixture_path do
          run_command("#{parser_bin} webserver.log --uniq-pageviews")
        end

        expect(last_command_started).to be_successfully_executed
        expect(last_command_started).to have_output(expected_output)
      end
    end
  end
end
