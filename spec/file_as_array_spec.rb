require 'file_as_array'

describe FileAsArray do
  subject(:file_as_array) { described_class.new('./sampleWebserver.log') }

  file_array = [
    '/help_page/1 126.318.035.038', '/contact 184.123.665.067',
    '/home 184.123.665.067',        '/about/2 444.701.448.104',
    '/help_page/1 929.398.951.889', '/index 444.701.448.104',
    '/help_page/1 722.247.931.582', '/about 061.945.150.735',
    '/help_page/1 646.865.545.408', '/home 235.313.352.950']

  describe '#initialize' do
    it 'should only accept .log files' do
      expect { FileAsArray.new('./README.md') }.to raise_error 'invalid file, must be .log'
    end
  end

  describe '#file_data' do
    it 'return file data in array form' do
      expect(file_as_array.file_data).to eq file_array
    end
  end
end