require 'parser'

describe Parser do
  subject(:parser) { described_class.new('./sampleWebserver.log') }

  results =
"/help_page/1 6 visits
/about/2 4 visits
/index 4 visits
/home 4 visits
/contact 4 visits
/about 3 visits"

  describe '#most_viewed_pages' do
    context 'given a file' do
      it 'should return popular pages with number of visits and new lines' do
        expect(parser.most_viewed_pages).to eq results
      end
    end
  end
end
