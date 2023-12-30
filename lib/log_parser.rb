# frozen_string_literal: true

module LogParser
  require_relative 'log_parser/data_sorters/pageviews'
  require_relative 'log_parser/data_sorters/uniq_pageviews'
  require_relative 'log_parser/view'

  def self.call(filename:, uniq_pageviews: false)
    # TODO: use uniq_pageviews
    pageviews = if uniq_pageviews
                  LogParser::DataSorters::UniqPageviews.call(filename:)
                else
                  LogParser::DataSorters::Pageviews.call(filename:)
                end

    LogParser::View.call(pageviews:)
  end
end
