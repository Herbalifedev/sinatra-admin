ENV['RACK_ENV'] = 'test'

app_file = File.join(File.dirname(__FILE__), '..', '..', 'dummy/dummy.rb')

require app_file
require 'capybara'
require 'capybara/cucumber'
require 'rspec'

# Does not work neither with config.ru nor dummy.rb files
Sinatra::Application.app_file = app_file
Capybara.app = Rack::Builder.parse_file(File.expand_path('../../../dummy/config.ru', __FILE__)).first

class DummyWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  DummyWorld.new
end
