module SinatraAdmin
  module Register
    class Model < Base
      def generate!(&block)
        app.namespace("/#{route}", &block) if block_given?
        app.instance_exec(resource_constant, route) do |model, route|
          before "/#{route}/?*" do
            @model = model
            @route = route
          end

          #INDEX
          get "/#{route}/?" do
            if params[:sort]
              if params[:asc] == 'false'
                @collection ||= model.all.desc(params[:sort])
              else
                @collection ||= model.all.asc(params[:sort])
              end
            else
              @collection ||= model.all
            end
            @collection = @collection.page(params[:page] || 1)

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
              redirect "/admin/#{@route}/#{@resource.id}"
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
              redirect "/admin/#{@route}/#{@resource.id}"
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
              redirect "/admin/#{route}/"
            else
              puts "Something wrong"
              status 400
            end
          end
        end
      end
    end #Model
  end #Register
end #SinatraAdmin
