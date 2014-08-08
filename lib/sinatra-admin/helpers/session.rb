module SinatraAdmin
  module SessionHelper
    def public_routes
      [
        '/admin/login',
        '/admin/login/',
        '/admin/unauthenticated',
        '/admin/unauthenticated/',
        '/admin/not_found/'
      ]
    end

    def authenticate!
      puts warden.inspect
      unless warden.authenticated?(:sinatra_admin)
        puts "in filter - not authenticated! #{request.path_info}"
        flash[:error] = "You must log in"
        redirect '/admin/login'
      end
    end

    def warden
      env['warden']
    end
  end
end
