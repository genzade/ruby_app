require 'parser'

describe Parser do
  subject(:parser){ described_class.new }

  mostViewed = {
    '/help_page/1' => 4,
    '/home' => 2,
    '/about/2' => 1,
    '/index' => 1,
    '/contact' => 1,
    '/about' => 1
  }

  describe '#most_viewed_pages' do
    it 'should open file path and return most viewed pages hash' do
      expect(parser.most_viewed_pages('./sampleWebserver.log')).to eq mostViewed
    end
  end
end