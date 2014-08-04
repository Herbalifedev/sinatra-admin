module SinatraAdmin
  class Config
    ATTRIBUTES = %i(root)

    ATTRIBUTES.each do |attr|
      attr_accessor attr
    end

    def default_route
      @default_route ||=
        if root
          route = root.underscore.pluralize
          raise RegistrationException, "The resource #{root} was not registered" unless routes.include?(route)
          "/admin/#{route}"
        else
          raise RegistrationException, 'You should register at least one resource' if routes.empty?
          "/admin/#{routes.first}"
        end
    end

    # Store all registered routes.
    # Executing:
    #   SinatraAdmin.register('User')
    #   SinatraAdmin.register('Tags')
    #
    # The result is going  to be:
    #   @routes => ['users', 'tags']
    def routes
      @routes ||= []
    end

    ########## USE THIS METHOD CAREFULLY! ###########
    # Sets ALL config to nil and remove ALL registered
    # routes. It means that this method is going to remove
    # the WHOLE SinatraAdmin functionality
    def reset!
      ATTRIBUTES.each {|attr| send("#{attr.to_s}=", nil)}
      routes.clear
    end
  end
end
