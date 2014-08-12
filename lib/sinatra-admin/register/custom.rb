module SinatraAdmin
  module Register
    class Custom < Base
      def generate!(&block)
        raise RegistrationException, "You should pass a block in order to register #{resource_constant} custom resource" unless block_given?
        app.namespace("/admin/#{route}", &block)
      end
    end #Custom
  end #Register
end #SinatraAdmin
