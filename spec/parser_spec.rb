require 'parser'

describe Parser do
  subject(:parser) { described_class.new('./sampleWebserver.log') }

  results =
'/help_page/1 6 visits
/about/2 4 visits
/index 4 visits
/home 4 visits
/contact 4 visits
/about 3 visits'

  unique_pageviews_result =
"/help_page/1 5 unique views
/home 4 unique views
/index 4 unique views
/contact 3 unique views
/about 3 unique views
/about/2 3 unique views"

  describe '#most_viewed_pages' do
    context 'given a file' do
      it 'should return popular pages with number of visits and new lines' do
        expect(parser.most_viewed_pages).to eq results
      end

      it 'should return pages with number of unique pageviews and new lines' do
        expect(parser.unique_pageviews).to eq unique_pageviews_result
      end
    end
  end
end
