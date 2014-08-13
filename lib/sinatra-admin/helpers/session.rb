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
      unless warden.authenticated?(:sinatra_admin)
        flash[:error] = "You must log in"
        redirect to('login')
      end
    end

    def warden
      env['warden']
    end
  end
end
