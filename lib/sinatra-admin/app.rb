require 'mongoid'
require 'warden'
require 'dotenv'
require 'rack/csrf'
require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra/flash'
require 'sinatra-admin/warden_strategies/sinatra_admin'
require 'sinatra-admin/helpers/session'
require "sinatra-admin/helpers/template_lookup"
require 'sinatra-admin/helpers/data_table'
require 'sinatra-admin/helpers/form_authenticity_token'
require 'will_paginate_mongoid'
require "will_paginate/view_helpers/sinatra"
require "sinatra-admin/helpers/sortable_params"
require "sinatra-admin/helpers/role_abilities"
require "sinatra-admin/presenters/csv_generator"

module SinatraAdmin
  class App < Sinatra::Base
    Dotenv.load ".env.#{settings.environment.to_s}"
    Mongoid.raise_not_found_error = false
    I18n.config.enforce_available_locales = false

    set :sessions, true
    set :views, [views]
    set :session_secret, ENV['SINATRA_ADMIN_SECRET']

    register Sinatra::Flash
    register Sinatra::Namespace

    helpers SinatraAdmin::SessionHelper
    helpers SinatraAdmin::TemplateLookupHelper
    helpers SinatraAdmin::SortableParamsHelper
    helpers SinatraAdmin::RoleAbilitiesHelper
    helpers SinatraAdmin::DataTableHelper
    helpers SinatraAdmin::FormAuthenticityTokenHelper
    helpers WillPaginate::Sinatra::Helpers

    use Rack::MethodOverride
    use Rack::Session::Cookie, secret: ENV['SINATRA_ADMIN_SECRET']
    use Rack::Csrf, :raise => true
    use Warden::Manager do |config|
      config.serialize_into_session(:sinatra_admin){|admin| admin.id }
      config.serialize_from_session(:sinatra_admin){|id| SinatraAdmin.config.admin_model.find(id) }
      config.scope_defaults :sinatra_admin,
        strategies: [:sinatra_admin],
        action: '/admin/unauthenticated'
      config.failure_app = SinatraAdmin::App
    end

    Warden::Manager.before_failure do |env,opts|
      env['REQUEST_METHOD'] = 'POST'
    end

    before do
      unless public_routes.include?(request.path)
        authenticate!
      end
    end

    get '/?' do
      redirect SinatraAdmin.config.default_route
    end

    get '/login/?' do
      haml 'auth/login'.to_sym, format: :html5, layout: false
    end

    post '/login/?' do
      if warden.authenticate(:sinatra_admin, scope: :sinatra_admin)
        redirect SinatraAdmin.config.default_route
      else
        flash.now[:error] = warden.message
        haml 'auth/login'.to_sym, format: :html5, layout: false
      end
    end

    get '/logout/?' do
      warden.logout(:sinatra_admin)
      flash[:success] = 'Successfully logged out'
      redirect '/admin/login'
    end

    post '/unauthenticated/?' do
      flash[:error] = warden.message || "You must log in"
      redirect '/admin/login'
    end
  end
end
