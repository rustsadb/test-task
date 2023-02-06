# frozen_string_literal: true

# rubocop: disable
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'

RSpec.shared_context :api do
  let(:response_body) { JSON.parse(response.body) }
  let(:response_errors) { JSON.parse(response.body)['errors'] }
end

RSpec.configure do |config|
  config.include_context :api
  config.use_transactional_fixtures = true
  config.include(Shoulda::Matchers::ActiveRecord, type: :controller)
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
# rubocop: enable
