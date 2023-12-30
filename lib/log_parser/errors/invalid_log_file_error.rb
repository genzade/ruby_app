# frozen_string_literal: true

module LogParser
  module Errors
    class InvalidLogFileError < StandardError
      attr_reader :filename

      def initialize(filename)
        super

        @filename = filename
      end

      def message
        "this file '#{filename}' is not a valid log file"
      end
    end
  end
end
