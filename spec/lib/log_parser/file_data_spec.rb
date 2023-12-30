# frozen_string_literal: true

require 'spec_helper'

require 'log_parser/file_data'

RSpec.describe LogParser::FileData do
  describe '.call' do
    it 'returns file sorted by visit_count and page' do
      filename = fixture('sm-webserver.log')
      file_data = LogParser::FileData.call(filename:)

      expect(file_data).to a_collection_containing_exactly(
        an_object_having_attributes(
          page: '/help_page/1',
          visit_count: 4,
          uniq_visit_count: 4,
          ips: ['126.318.035.038', '929.398.951.889', '722.247.931.582', '646.865.545.408'],
        ),
        an_object_having_attributes(
          page: '/contact',
          visit_count: 1,
          uniq_visit_count: 1,
          ips: ['184.123.665.067'],
        ),
        an_object_having_attributes(
          page: '/home',
          visit_count: 2,
          uniq_visit_count: 2,
          ips: ['184.123.665.067', '235.313.352.950'],
        ),
        an_object_having_attributes(
          page: '/about/2',
          visit_count: 1,
          uniq_visit_count: 1,
          ips: ['444.701.448.104'],
        ),
        an_object_having_attributes(
          page: '/index',
          visit_count: 1,
          uniq_visit_count: 1,
          ips: ['444.701.448.104'],
        ),
        an_object_having_attributes(
          page: '/about',
          visit_count: 1,
          uniq_visit_count: 1,
          ips: ['061.945.150.735'],
        ),
      )
    end

    context 'with a larger log file' do
      it 'returns file sorted by visit_count and page' do
        filename = fixture('webserver.log')
        file_data = LogParser::FileData.call(filename:)

        expect(file_data).to a_collection_containing_exactly(
          an_object_having_attributes(
            page: '/help_page/1',
            visit_count: 8,
            uniq_visit_count: 6,
            ips: ['126.318.035.038', '929.398.951.889', '722.247.931.582', '646.865.545.408',
                  '543.910.244.929', '929.398.951.889', '929.398.951.889', '836.973.694.403'],
          ),
          an_object_having_attributes(
            page: '/contact',
            visit_count: 9,
            ips: ['184.123.665.067', '184.123.665.067', '543.910.244.929', '555.576.836.194',
                  '200.017.277.774', '316.433.849.805', '836.973.694.403', '184.123.665.067',
                  '158.577.775.616'],
          ),
          an_object_having_attributes(
            page: '/home',
            visit_count: 10,
            uniq_visit_count: 8,
            ips: ['184.123.665.067', '235.313.352.950', '316.433.849.805', '444.701.448.104',
                  '336.284.013.698', '444.701.448.104', '444.701.448.104', '382.335.626.855',
                  '802.683.925.780', '451.106.204.921'],
          ),
          an_object_having_attributes(
            page: '/about/2',
            visit_count: 7,
            uniq_visit_count: 6,
            ips: ['444.701.448.104', '444.701.448.104', '836.973.694.403', '184.123.665.067',
                  '382.335.626.855', '543.910.244.929', '555.576.836.194'],
          ),
          an_object_having_attributes(
            page: '/index',
            visit_count: 5,
            uniq_visit_count: 5,
            ips: ['444.701.448.104', '316.433.849.805', '802.683.925.780', '929.398.951.889',
                  '184.123.665.067'],
          ),
          an_object_having_attributes(
            page: '/about',
            visit_count: 11,
            uniq_visit_count: 9,
            ips: ['061.945.150.735', '126.318.035.038', '235.313.352.950', '836.973.694.403',
                  '929.398.951.889', '715.156.286.412', '336.284.013.698', '715.156.286.412',
                  '722.247.931.582', '715.156.286.412', '897.280.786.156'],
          ),
        )
      end
    end

    context 'when file does not exist' do
      it 'raises an error' do
        filename = 'non-existent-file.wha'
        file_data = LogParser::FileData.new(filename:)

        expect { file_data.call }
          .to raise_error(
            LogParser::Errors::MissingFileError,
            "this file '#{filename}' does not exist",
          )
      end
    end

    context 'when file is not a valid log file' do
      it 'raises an error' do
        filename = fixture('not-a-log.file')
        file_data = LogParser::FileData.new(filename:)

        expect { file_data.call }
          .to raise_error(
            LogParser::Errors::InvalidLogFileError,
            "this file '#{filename}' is not a valid log file",
          )
      end
    end
  end
end
