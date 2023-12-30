# frozen_string_literal: true

require_relative './errors/missing_file_error'
require_relative './errors/invalid_log_file_error'

module LogParser
  class FileData
    LOGPARSER_REGEX = %r{(?<page>/[a-z_]+/?\d?)\s(?<ip>\d{3}.\d{3}.\d{3}.\d{3})}
    NEWLINE_CHAR = "\n"
    Data = Struct.new(
      :page,
      :visit_count,
      :uniq_visit_count,
      :ips,
      keyword_init: true,
    )

    def self.call(...)
      new(...).call
    end

    def initialize(filename:)
      @filename = filename
    end

    def call
      raise LogParser::Errors::MissingFileError, filename unless file_exists?

      grouped_by_page = regex_matched.group_by { |matchdata| matchdata[:page] }

      grouped_by_page.map do |page, matched_data|
        ips = matched_data.map { |data| data[:ip] }
        visit_count = ips.size
        uniq_visit_count = ips.uniq.size

        Data.new(page:, visit_count:, uniq_visit_count:, ips:)
      end
    end

    private

    attr_reader :filename

    def regex_matched
      file = File.open(filename)

      file.read.split(NEWLINE_CHAR).map do |line|
        valid_log_line = line.match(LOGPARSER_REGEX)

        raise LogParser::Errors::InvalidLogFileError, filename if valid_log_line.nil?

        valid_log_line
      end
    end

    def file_exists?
      File.exist?(filename)
    end
  end
end
