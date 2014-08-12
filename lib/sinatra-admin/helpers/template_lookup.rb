module SinatraAdmin
  module TemplateLookupHelper
    def find_template(views, name, engine, &block)
      Array(views).each { |v| super(v, name, engine, &block) }
    end
  end #TemplateLookupHelper
end #SinatraAdmin
