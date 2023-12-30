# frozen_string_literal: true

module LogParser
  module Errors
    class MissingFileError < StandardError
      attr_reader :filename

      def initialize(filename)
        super

        @filename = filename
      end

      def message
        "this file '#{filename}' does not exist"
      end
    end
  end
end
