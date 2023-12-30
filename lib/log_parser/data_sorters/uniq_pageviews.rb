# frozen_string_literal: true

require_relative './base_sorter'

module LogParser
  module DataSorters
    class UniqPageviews < BaseSorter
      VISIT_STRING = 'unique view'

      def call
        sorted_data.map do |data|
          {
            page: data.page,
            visit_count: data.uniq_visit_count,
            visit_string: VISIT_STRING,
          }
        end
      end

      private

      def sorted_data
        grouped_data.sort do |data1, data2|
          [-data1.uniq_visit_count, data1.page] <=> [-data2.uniq_visit_count, data2.page]
        end
      end
    end
  end
end
