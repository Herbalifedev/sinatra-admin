require 'sinatra/base'
require "sinatra/namespace"

module SinatraAdmin
  class App < Sinatra::Base
    use Rack::MethodOverride

    register Sinatra::Namespace

    namespace '/admin' do
      get '/?' do
        redirect to(SinatraAdmin.config.default_route)
      end
    end
  end
end
