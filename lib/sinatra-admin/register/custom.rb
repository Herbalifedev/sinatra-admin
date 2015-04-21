module SinatraAdmin
  module Register
    class Custom < Base
      def generate!
        raise RegistrationException, "You should pass a block in order to register #{resource_constant} custom resource" unless configure.resource
        app.namespace("/#{route}", &configure.resource)
      end
    end #Custom
  end #Register
end #SinatraAdmin
