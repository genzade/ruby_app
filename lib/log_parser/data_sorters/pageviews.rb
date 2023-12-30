# frozen_string_literal: true

require_relative './base_sorter'

module LogParser
  module DataSorters
    class Pageviews < BaseSorter
      VISIT_STRING = 'visit'

      def call
        sorted_data.map do |data|
          {
            page: data.page,
            visit_count: data.visit_count,
            visit_string: VISIT_STRING,
          }
        end
      end

      private

      def sorted_data
        grouped_data.sort do |data1, data2|
          [-data1.visit_count, data1.page] <=> [-data2.visit_count, data2.page]
        end
      end
    end
  end
end
