module SinatraAdmin
  module Register
    class Base
      class << self
        def add(resource_constant, &block)
          route = resource_constant.to_s.downcase.split.join('_').pluralize
          if SinatraAdmin.config.routes.include?(route)
            raise RegistrationException, "The resource #{resource_constant.to_s} is already registered"
          else
            SinatraAdmin.config.routes << route
            new(resource_constant, route).generate!(&block)
          end
        end
      end

      attr_reader :app, :resource_constant, :route

      def initialize(resource_constant, route)
        @app   = SinatraAdmin::App
        @route = route
        @resource_constant = resource_constant
      end

      def generate!
        raise NotImplementedError, 'You must implement me!'
      end
    end #Base
  end #Register
end #SinatraAdmin
