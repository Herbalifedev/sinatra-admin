require 'active_support/inflector'

require "sinatra-admin/version"
require 'sinatra-admin/app'
require 'sinatra-admin/register'
require 'sinatra-admin/config'

module SinatraAdmin
  class << self
    def register(constant_name)
      Register.add(constant_name)
    end

    def root(default)
      config.root = default
    end

    def config
      @config ||= Config.new
    end
  end
end
