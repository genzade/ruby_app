require 'parser'

describe Parser do
  subject(:parser) { described_class.new('./sampleWebserver.log') }

  mostViewed = {
    '/help_page/1' => 4,
    '/home' => 2,
    '/about/2' => 1,
    '/index' => 1,
    '/contact' => 1,
    '/about' => 1
  }
  results =
    "/help_page/1 4 visits\n/home 2 visits\n/about/2 1 visits\n/index 1 visits\n/contact 1 visits\n/about 1 visits"

  describe '#most_viewed_pages' do
    it 'should open file path and return most viewed pages hash' do
      expect(parser.most_viewed_pages).to eq mostViewed
    end
  end

  # describe '#display_most_viewed' do
  #   it 'should return results as string' do
  #     expect(parser.display_most_viewed).to eq results
  #   end
  # end
end
