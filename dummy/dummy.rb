require 'sinatra-admin'
require 'sinatra/base'

require_relative 'models/user'
require_relative 'models/comment'

module Dummy
  class Base < Sinatra::Base
    set :root, File.dirname(__FILE__)
    Mongoid.load!("dummy/config/mongoid.yml")
    I18n.enforce_available_locales = false
  end

  class API < Base
  end

  class Admin < Base
  end
end
