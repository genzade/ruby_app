# frozen_string_literal: true

require_relative '../../log_parser/file_data'

module LogParser
  module DataSorters
    class BaseSorter
      def self.call(...)
        new(...).call
      end

      def initialize(filename:)
        @filename = filename
      end

      def call
        raise NotImplementedError
      end

      private

      attr_reader :filename

      def sorted_data
        raise NotImplementedError
      end

      def grouped_data
        LogParser::FileData.call(filename:)
      end
    end
  end
end
