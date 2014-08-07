After do |scenario| 
  Warden.test_reset!
end

module WardenWorld
  include Warden::Test::Helpers
end

World(WardenWorld)
