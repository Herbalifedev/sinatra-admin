module SinatraAdmin
  class RegistrationException < Exception; end

  class Register
    class << self
      def add(constant_name)
        model = constant_name.constantize
        route = constant_name.underscore.pluralize
        if SinatraAdmin.config.routes.include?(route)
          raise RegistrationException, "The resource #{constant_name} is already registered"
        else
          SinatraAdmin.config.routes << route
          new(model, route).generate!
        end
      end
    end

    attr_reader :app, :model, :route

    def initialize(model, route)
      @app   = SinatraAdmin::App
      @model = model
      @route = route
    end

    def generate!
      app.instance_exec(model, route) do |model, route|
        namespace '/admin' do
          before "/#{route}/?*" do
            @model = model
            @route = route
          end

          #INDEX
          get "/#{route}/?" do
            @collection = model.all.entries
            haml :index, format: :html5
          end

          #NEW
          get "/#{route}/new/?" do
            @resource = model.new
            haml :new, format: :html5
          end

          #CREATE
          post "/#{route}/?" do
            @resource = model.new(params[:data])
            if @resource.save
              puts "Resource was created"
              redirect to("/admin/#{@route}/#{@resource.id}")
            else
              puts "Validation Errors"
              haml :new, format: :html5
            end
          end

          #SHOW
          get "/#{route}/:id/?" do
            @resource = model.find(params[:id])
            haml :show, format: :html5
          end

          #EDIT
          get "/#{route}/:id/edit/?" do
            @resource = model.find(params[:id])
            haml :edit, format: :html5
          end

          #UPDATE
          put "/#{route}/:id/?" do
            @resource = model.find(params[:id])
            if @resource.update_attributes(params[:data])
              puts "Resource was updated"
              redirect to("/admin/#{@route}/#{@resource.id}")
            else
              puts "Validation Errors"
              haml :edit, format: :html5
            end
          end

          #DESTROY
          delete "/#{route}/:id/?" do
            @resource = model.find(params[:id])
            if @resource.destroy
              puts "Resource was destroyed"
              redirect to("/admin/#{route}/")
            else
              puts "Something wrong"
              status 400
            end
          end
        end
      end
    end
  end
end
