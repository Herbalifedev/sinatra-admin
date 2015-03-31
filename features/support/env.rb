ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'dummy/dummy.rb')
require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.default_driver = :selenium
Capybara.app = Rack::Builder.parse_file('./dummy/config.ru').first
Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 30
#Capybara.register_driver :selenium do |app|
#  Capybara::Selenium::Driver.new(app, :browser => :chrome)
#end

class DummyWorld
  include Capybara::DSL
  include RSpec::Matchers
  include RSpec::Expectations
end

World do
  DummyWorld.new
end
