require 'active_support/inflector'

require "sinatra-admin/version"
require "sinatra-admin/warden"
require 'sinatra-admin/app'
require 'sinatra-admin/register'
require 'sinatra-admin/config'
require 'sinatra-admin/models/admin'

module SinatraAdmin
  class << self
    def register(constant_name)
      Register.add(constant_name)
    end

    def config
      @config ||= Config.new
    end

    def root(default)
      config.root = default
    end

    def admin_model(constant_name)
      config.admin_model = constant_name.constantize
    end
  end
end
