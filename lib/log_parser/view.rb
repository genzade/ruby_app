# frozen_string_literal: true

module LogParser
  class View
    SPACE_CHAR = ' '
    SEPARATORS = '........'

    def self.call(...)
      new(...).call
    end

    def initialize(pageviews:)
      @pageviews = pageviews
    end

    def call
      return '' if pageviews.empty?

      sanitize(pageviews).map do |pageview|
        page, visit_count, visit_string =
          pageview.values_at(:page, :visit_count, :visit_string)

        visit_string += 's' if visit_count > 1

        visit_count_string = visit_count.to_s
        visit_count_string += offset_str(5, visit_count_string.size)

        [page, SEPARATORS, visit_count_string, visit_string].join(SPACE_CHAR)
      end.join("\n")
    end

    private

    attr_reader :pageviews

    def sanitize(pageviews)
      # this should move to the class that builds the pageviews objects
      # max_page_string = pageviews.max_by(&:length)[:page].size

      # change this because pageviews data now has visit_count
      max_page_string = pageviews.max_by { |pageview| pageview[:page].size }[:page].size

      pageviews.map do |pageview|
        pageview[:page] += offset_str(max_page_string, pageview[:page].size)
      end

      pageviews
    end

    def offset_str(offset, string_length)
      SPACE_CHAR * (offset - string_length)
    end
  end
end
