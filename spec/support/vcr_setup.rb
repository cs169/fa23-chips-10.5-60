# frozen_string_literal: true

require 'vcr'
require 'rails'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.allow_http_connections_when_no_cassette = true
  config.ignore_localhost = true
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<GOOGLE_CIVIC_API_KEY>') { Rails.application.credentials[:GOOGLE_API_KEY] }
  config.filter_sensitive_data('<PROPUBLICA_API_KEY>') { Rails.application.credentials[:PROPUBLICA_API_KEY] }
  config.default_cassette_options = {
    record: :new_episodes
  }
end
