module SinatraAdmin
  module Register
    class Configure

      # custom resource
      attr_reader :resource
      
      attr_reader :resource_constant
      attr_reader :fields
      
      def initialize (resource_constant)
        @fields = {}
        @resource_constant = resource_constant
      end

      def route (&block)
        @resource = block
      end
      
      
      def columns (cols) 
        cols.each do |c|
          fields[c] ||= {}
          fields[c][:visible] = true
        end
      end
      
      def attribute_names
        if fields.length > 0
          fields.keys
        else
          resource_constant.attribute_names
        end
      end

      # Custom function to render a column
      def renderer (attr, &block)
        fields[attr] ||= {}
        fields[attr][:render] = block if block_given?
      end
      
      def render (attr, row)
        if fields[attr] && fields[attr][:render]
          fields[attr][:render].call(attr, row)
        else
          row[attr]
        end
      rescue
        row[attr]
      end
      
      

    end #Configure
  end #Register
end #SinatraAdmin
