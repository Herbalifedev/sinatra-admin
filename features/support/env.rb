ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'dummy/dummy.rb')
require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = Rack::Builder.parse_file('./dummy/config.ru').first

class DummyWorld
  include Capybara::DSL
  include RSpec::Matchers
  include RSpec::Expectations
end

World do
  DummyWorld.new
end
