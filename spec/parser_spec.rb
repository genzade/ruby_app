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

  unique_pageviews = {
    '126.318.035.038' => ['/help_page/1', '/about'],
    '184.123.665.067' => ['/contact', '/home', '/about/2'],
    '444.701.448.104' => ['/about/2', '/index', '/home'],
    '929.398.951.889' => ['/help_page/1', '/index'],
    '722.247.931.582' => ['/help_page/1'],
    '061.945.150.735' => ['/about'],
    '646.865.545.408' => ['/help_page/1'],
    '235.313.352.950' => ['/home', '/about'],
    '543.910.244.929' => ['/help_page/1', '/contact'],
    '316.433.849.805' => ['/home', '/index'],
    '836.973.694.403' => ['/about/2'],
    '802.683.925.780' => ['/index'],
    '555.576.836.194' => ['/contact']
  }

  describe '#most_viewed_pages' do
    context 'given a file' do
      it 'should return popular pages with number of visits and new lines' do
        expect(parser.most_viewed_pages).to eq results
      end

      it 'returns hash with key, value IP address => pages viewed' do
        expect(parser.unique).to eq unique_pageviews
      end
    end
  end
end
