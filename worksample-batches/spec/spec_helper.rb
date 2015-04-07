ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'

unless ENV["NO_COVERAGE"]
  SimpleCov.start 'rails'
end

require File.expand_path("../../config/environment", __FILE__)

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

require 'rspec/rails'
require 'webmock/rspec'

RSpec.configure do |config|
  config.order = "random"
  config.infer_spec_type_from_file_location!

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false

  config.alias_example_to       :focus, :focus => true
  config.alias_example_group_to :focus_group, :focus => true

  config.filter_run_excluding disabled: true
  config.filter_run_excluding slow: true

  config.before(:each) do
    WebMock.disable_net_connect!
    EasyPost::Job.pool.clear
    allow(Rails.logger).to receive(:error)
  end

  config.around(:each) do |example|
    if example.metadata[:webmock_only]
      VCR.turn_off!
      WebMock::HttpLibAdapters::TyphoeusAdapter.enable!
    end

    example.call

    if example.metadata[:webmock_only]
      WebMock::HttpLibAdapters::TyphoeusAdapter.disable!
      VCR.turn_on!
    end
  end
end

