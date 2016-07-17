require 'parser'

describe Parser do
  subject(:parser) { described_class.new('./sampleWebserver.log') }

  file_array = [
    '/help_page/1 126.318.035.038', '/contact 184.123.665.067',
    '/home 184.123.665.067',        '/about/2 444.701.448.104',
    '/help_page/1 929.398.951.889', '/index 444.701.448.104',
    '/help_page/1 722.247.931.582', '/about 061.945.150.735',
    '/help_page/1 646.865.545.408', '/home 235.313.352.950']

  results =
    "/help_page/1 4 visits\n/home 2 visits\n/about/2 1 visits\n/index 1 visits\n/contact 1 visits\n/about 1 visits"

  describe '#file_arr' do
    it 'should only accept .log files' do
      expect(parser.file_arr('./sampleWebserver.log')).to eq file_array
    end

    it 'should throw exception if not .log file' do
      expect { parser.file_arr('./README.md') }.to raise_error 'invalid file, must be .log'
    end
  end

  describe '#most_viewed_pages' do
    context 'given a file' do
      it 'should return popular pages with number of visits and new lines' do
        expect(parser.most_viewed_pages).to eq results
      end
    end
  end
end
