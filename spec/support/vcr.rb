# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
  # Filter sensitive data
  config.filter_sensitive_data('<ACCOUNT_SID>') { ENV['ACCOUNT_SID'] }
  config.filter_sensitive_data('<AUTH_TOKEN>') { ENV['AUTH_TOKEN'] }
  config.filter_sensitive_data('<TWILIO_PHONE>') { ENV['TWILIO_PHONE'] }
end
