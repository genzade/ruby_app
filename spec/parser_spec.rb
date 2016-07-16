require 'parser'

describe Parser do
  subject(:parser) { described_class.new('./sampleWebserver.log') }

  results =
    "/help_page/1 4 visits\n/home 2 visits\n/about/2 1 visits\n/index 1 visits\n/contact 1 visits\n/about 1 visits"

  describe '#most_viewed_pages' do
    context 'given a file' do
      it 'should return popular pages with number of visits and new lines' do
        expect(parser.most_viewed_pages).to eq results
      end
    end
  end
end
