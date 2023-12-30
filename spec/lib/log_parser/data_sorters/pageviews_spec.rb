# frozen_string_literal: true

require 'spec_helper'

require 'log_parser/data_sorters/pageviews'

RSpec.describe LogParser::DataSorters::Pageviews do
  describe '.call' do
    it 'returns file sorted by visit_count' do
      filename = fixture('webserver.log')
      pageviews = LogParser::DataSorters::Pageviews.call(filename:)
      visit_string = LogParser::DataSorters::Pageviews::VISIT_STRING

      expect(pageviews).to eq(
        [
          {
            page: '/about',
            visit_count: 11,
            visit_string:,
          },
          {
            page: '/home',
            visit_count: 10,
            visit_string:,
          },
          {
            page: '/contact',
            visit_count: 9,
            visit_string:,
          },
          {
            page: '/help_page/1',
            visit_count: 8,
            visit_string:,
          },
          {
            page: '/about/2',
            visit_count: 7,
            visit_string:,
          },
          {
            page: '/index',
            visit_count: 5,
            visit_string:,
          },
        ],
      )
    end

    context 'when there are non unique visit_counts' do
      it 'returns file sorted by visit_count and page' do
        filename = fixture('sm-webserver.log')
        pageviews = LogParser::DataSorters::Pageviews.call(filename:)
        visit_string = LogParser::DataSorters::Pageviews::VISIT_STRING

        expect(pageviews).to eq(
          [
            {
              page: '/help_page/1',
              visit_count: 4,
              visit_string:,
            },
            {
              page: '/home',
              visit_count: 2,
              visit_string:,
            },
            {
              page: '/about',
              visit_count: 1,
              visit_string:,
            },
            {
              page: '/about/2',
              visit_count: 1,
              visit_string:,
            },
            {
              page: '/contact',
              visit_count: 1,
              visit_string:,
            },
            {
              page: '/index',
              visit_count: 1,
              visit_string:,
            },
          ],
        )
      end
    end
  end
end
