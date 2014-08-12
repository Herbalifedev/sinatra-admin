require 'active_support/inflector'

require "sinatra-admin/version"
require 'sinatra-admin/app'
require 'sinatra-admin/register'
require 'sinatra-admin/config'
require 'sinatra-admin/models/admin'

module SinatraAdmin
  class << self
    def register(constant_name, &block)
      begin
        model = constant_name.constantize
        Register::Model.add(model)
      rescue NameError => error #Model does not exist
        Register::Custom.add(constant_name, &block)
      end
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

    def add_views_from(main_app)
      Array(main_app.views).each do |view|
        SinatraAdmin::App.views << "#{view}/admin"
      end
    end
  end #class << self
end #SinatraAdmin
