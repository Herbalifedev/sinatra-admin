module SinatraAdmin
  module Register
    class Model < Base
      def generate!
        app.namespace("/#{route}", &configure.resource) if configure.resource
        app.instance_exec(resource_constant, route, configure) do |model, route, configure|
          before "/#{route}/?*" do
            @model = model
            @route = route
            @configure = configure
          end

          get "/#{route}/data/json/?" do
            #SinatraAdmin::Presenters::DataTable.new(model, configure, params)
            content_type 'application/json'
            dt_json
          end

          #INDEX
          get "/#{route}/?" do
            can_read? #Role ability
            @collection = []
            haml :index, format: :html5
          end

          #EXPORT ALL
          get "/#{route}/export/all/?" do
            can_read? #Role ability
            @collection = model.unscoped.all
            if params[:data]
              data = JSON.parse(params[:data])
              order = data["order"]
              order.each do |x|
                cidx = x["column"].to_i
                cdir = x["dir"]
                attr = configure.attribute_names[cidx]
                @collection = @collection.send(cdir, attr)
              end if order
            end
         
            content_type 'text/csv', 'charset' => 'utf-8'
            attachment "#{route}-all-#{Date.today.to_s}.csv"
            #TODO: http://stackoverflow.com/questions/4348802/how-can-i-output-a-utf-8-csv-in-php-that-excel-will-read-properly 
            SinatraAdmin::Presenters::CsvGenerator.new(@collection, configure.attribute_names).export_csv
          end

          #NEW
          get "/#{route}/new/?" do
            can_create? #Role ability
            @resource = model.new
            haml :new, format: :html5
          end

          #CREATE
          post "/#{route}/?" do
            can_create? #Role ability
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
            can_read? #Role ability
            @resource = model.find(params[:id])
            haml :show, format: :html5
          end

          #EDIT
          get "/#{route}/:id/edit/?" do
            can_edit? #Role ability
            @resource = model.find(params[:id])
            haml :edit, format: :html5
          end

          #UPDATE
          put "/#{route}/:id/?" do
            can_edit? #Role ability
            @resource = model.find(params[:id])
            if @resource.update_attributes(params[:data])
              puts "Resource was updated"
              redirect "/admin/#{@route}/#{@resource.id}"
            else
              puts "Validation Errors"
              haml :edit, format: :html5
            end
          end

          # CHANGE PASSWORD
          get "/#{route}/:id/change_password/?" do
            @resource = model.find(params[:id])
            haml :change_password, format: :html5
          end

          #UPDATE PASSWORD
          put "/#{route}/:id/update_password/?" do
            can_edit? #Role ability
            @resource = model.find(params[:id])
            if @resource.update_attributes(params[:data])
              puts "Resource was updated"
              redirect "/admin/#{@route}/#{@resource.id}"
            else
              puts "Validation Errors"
              haml :change_password, format: :html5
            end
          end

          #DESTROY
          delete "/#{route}/:id/?" do
            can_remove? #Role ability
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
