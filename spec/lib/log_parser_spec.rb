# frozen_string_literal: true

require 'spec_helper'

require 'log_parser'

RSpec.describe LogParser do
  describe '.call' do
    it 'prints the contents of the file separated with new lines' do
      filename = fixture('webserver.log')
      parser = LogParser.call(filename:)

      expect(parser).to eq(<<~OUTPUT.chomp)
        /about       ........ 11    visits
        /home        ........ 10    visits
        /contact     ........ 9     visits
        /help_page/1 ........ 8     visits
        /about/2     ........ 7     visits
        /index       ........ 5     visits
      OUTPUT
    end

    context 'with `uniq_pageviews` option' do
      it 'prints the contents of the file separated with new lines' do
        filename = fixture('webserver.log')
        parser = LogParser.call(filename:, uniq_pageviews: true)

        expect(parser).to eq(<<~OUTPUT.chomp)
          /about       ........ 9     unique views
          /home        ........ 8     unique views
          /contact     ........ 7     unique views
          /about/2     ........ 6     unique views
          /help_page/1 ........ 6     unique views
          /index       ........ 5     unique views
        OUTPUT
      end
    end
  end
end
