# frozen_string_literal: true

if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start 'rails' do
    add_filter '/.bundle/'
    add_filter '/vendor/bundle/'
  end
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

# rubocop:disable Style/ClassAndModuleChildren
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml
  # for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # Add more helper methods to be used by all tests here...
end
# rubocop:enable Style/ClassAndModuleChildren
