# frozen_string_literal: true

require 'spec_helper'

require 'log_parser/view'

RSpec.describe LogParser::View do
  describe '.call' do
    it 'returns a prettified view' do
      pageviews = [
        {
          page: '/help_page/1',
          visit_count: 63_949,
          visit_string: 'visit',
        },
        {
          page: '/home',
          visit_count: 5381,
          visit_string: 'visit',
        },
        {
          page: '/about',
          visit_count: 431,
          visit_string: 'visit',
        },
        {
          page: '/about/2',
          visit_count: 37,
          visit_string: 'visit',
        },
        {
          page: '/contact',
          visit_count: 2,
          visit_string: 'visit',
        },
        {
          page: '/index',
          visit_count: 1,
          visit_string: 'visit',
        },
      ]
      view = LogParser::View.call(pageviews:)

      expect(view).to eq(<<~OUTPUT.chomp)
        /help_page/1 ........ 63949 visits
        /home        ........ 5381  visits
        /about       ........ 431   visits
        /about/2     ........ 37    visits
        /contact     ........ 2     visits
        /index       ........ 1     visit
      OUTPUT
    end

    context 'with uniq pageviews' do
      it 'returns a prettified view' do
        pageviews = [
          {
            page: '/help_page/1',
            visit_count: 63_949,
            visit_string: 'unique view',
          },

          {
            page: '/home',
            visit_count: 5381,
            visit_string: 'unique view',
          },

          {
            page: '/about',
            visit_count: 431,
            visit_string: 'unique view',
          },
          {
            page: '/about/2',
            visit_count: 37,
            visit_string: 'unique view',
          },
          {
            page: '/contact',
            visit_count: 2,
            visit_string: 'unique view',
          },
          {
            page: '/index',
            visit_count: 1,
            visit_string: 'unique view',
          },
        ]
        view = LogParser::View.call(pageviews:)

        expect(view).to eq(<<~OUTPUT.chomp)
          /help_page/1 ........ 63949 unique views
          /home        ........ 5381  unique views
          /about       ........ 431   unique views
          /about/2     ........ 37    unique views
          /contact     ........ 2     unique views
          /index       ........ 1     unique view
        OUTPUT
      end
    end

    context 'when pageviews argument is empty' do
      it 'does something else' do
        pageviews = []
        view = LogParser::View.call(pageviews:)

        expect(view).to eq('')
      end
    end
  end
end
