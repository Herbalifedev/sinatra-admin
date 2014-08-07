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
      unless warden.authenticated?(:admin)
        flash[:error] = warden.message || "You must log in"
        redirect to('/admin/login')
      end
    end

    def warden
      env['warden']
    end
  end
end
