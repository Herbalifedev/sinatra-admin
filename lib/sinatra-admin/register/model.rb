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
            sort_attr, sort_by = params[:sort].blank? ? %w(created_at desc) : params[:sort].split(" ")
            @collection = model.send(sort_by, sort_attr).page(params[:page] || 1)
            p '-----------------------------------'
            p @collection.each {|a| p "Firstname: #{a.first_name}, Email: #{a.email}"}
            haml :index, format: :html5
          end

          #EXPORT ALL
          get "/#{route}/export/all/?" do
            sort_attr, sort_by = params[:sort].blank? ? %w(created_at desc) : params[:sort].split(" ")
            @collection = model.send(sort_by, sort_attr)
            content_type 'application/csv'
            attachment "#{route}-all-#{Date.today.to_s}.csv"
            Presenters::CsvGenerator.new(@collection, model.attribute_names).export_csv
          end

          #EXPORT CURRENT PAGE
          get "/#{route}/export/page/?" do
            sort_attr, sort_by = params[:sort].blank? ? %w(created_at desc) : params[:sort].split(" ")
            @collection = model.send(sort_by, sort_attr).page(params[:page] || 1)
            content_type 'application/csv'
            attachment "#{route}-page-#{Date.today.to_s}.csv"
            Presenters::CsvGenerator.new(@collection, model.attribute_names).export_csv
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
