require 'sinatra/base'
require 'sinatra-admin'

require_relative 'models/user'

class Dummy < Sinatra::Base
  set :root, File.dirname(__FILE__)

  Mongoid.load!("dummy/config/mongoid.yml")

  #get '/' do
  #  'Hello Dummy!'
  #end

  I18n.enforce_available_locales = false
end
