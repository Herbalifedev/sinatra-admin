module SinatraAdmin
  module RoleAbilitiesHelper
    def can_create?
      not_allow_access! unless warden.user(:sinatra_admin).create_access?
    end

    def can_edit?
      not_allow_access! unless warden.user(:sinatra_admin).edit_access?
    end

    def can_read?
      not_allow_access! unless warden.user(:sinatra_admin).read_access?
    end

    def can_remove?
      not_allow_access! unless warden.user(:sinatra_admin).remove_access?
    end

    private
    def not_allow_access!
      flash[:notice] = "Sorry you aren't allow to access"
      redirect SinatraAdmin.config.default_route
    end
  end
end