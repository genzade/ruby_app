# frozen_string_literal: true

require 'aruba/api'

Aruba.configure do |config|
  config.allow_absolute_paths = true
end

RSpec.configure do |config|
  config.include Aruba::Api

  config.before do
    setup_aruba
  end
end
