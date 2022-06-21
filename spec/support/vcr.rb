# frozen_string_literal: true

require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!

  # Filter out secrets defined in environment
  REQUIRED_ENV_KEYS.dup.each do |key|
    next if ENV[key] && ENV[key].empty?

    config.filter_sensitive_data("<#{key}>") { ENV[key] }
  end
end
