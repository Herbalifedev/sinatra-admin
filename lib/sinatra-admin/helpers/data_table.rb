module SinatraAdmin
  module DataTableHelper
    extend self
 
    def dt_json

      records = dt_source
      recordsTotal = records.count
      
      records = dt_order(records)
      records = dt_filter(records)
      recordsFiltered = records.count
      
      records = dt_limit(records)

      data = []
      records.each do |row|
        item = {}
        @configure.attribute_names.each do |attr|
          if attr.include?('.')
            assoc_key, assoc_attr = attr.split('.')
            if assoc_key.singularize == assoc_key
              item[assoc_key] = {} unless item[assoc_key]
              item[assoc_key] = item[assoc_key].merge({"_id" => row.send(assoc_key).id, "#{assoc_attr}" => row.send(assoc_key).send(assoc_attr)})
            end
          else
            item[attr] = row[attr]
          end
        end
        data << item
      end

      {
        draw: params[:draw] ? params[:draw].to_i : 1,
        recordsTotal: recordsTotal,
        recordsFiltered: recordsFiltered,
        data: data
      }.to_json
    end

    def dt_order (records)
      sort_column_index, sort_direction = params[:order]['0'].values_at('column', 'dir')
      sort_column = @configure.attribute_names[sort_column_index.to_i]
      sort_attr = sort_column.include?('.') ? @model.reflect_on_association(sort_column.split('.').first).key : sort_column
      records.send(sort_direction, sort_attr)
    end

    def dt_limit (records)
      return records if params[:start].blank? && params[:length].blank?
      records.skip(params[:start]).limit(params[:length])
    end

    def dt_source ()
      if params[:order].count > 0
        records = @model.unscoped.all
      else
        records = @model.all
      end
      records
    end

    #
    # ~ Filters ---------------------------------------------------------------- 
    #
    
    def dt_filter (records)
      params[:columns].each_value do |column|
        attr_name = column[:data]
        keyword = column[:search][:value]
        if attr_name.include?('.') && keyword.present?
          assoc_key, assoc_attr = attr_name.split('.')
          nested_record_ids = filter_associated_attrs(assoc_key, assoc_attr, keyword).pluck(:_id)
          records = records.in(assoc_key.foreign_key.to_sym => nested_record_ids)
        else
            records = filter_attrs(records, attr_name, keyword) if keyword.present?
        end
      end
      records
    end

    private
    def filter_associated_attrs assoc_key, assoc_attr, keyword
      model_class = assoc_key.classify.constantize
      data_type = model_class.fields[assoc_attr].type
      if [Integer, Float, BigDecimal, Moped::BSON::ObjectId, Date].include?(data_type)
        model_class.where(assoc_attr.to_sym => keyword)
      elsif [DateTime, Time].include?(data_type)
        model_class.where(assoc_attr.to_sym => keyword.to_date.beginning_of_day..keyword.to_date.end_of_day)
      else
        model_class.where(assoc_attr.to_sym => /#{keyword}/)
      end
    end

    def filter_attrs records, attr_name, keyword
      data_type = @model.fields[attr_name].type
      if [Integer, Float, BigDecimal, Moped::BSON::ObjectId, Date].include?(data_type)
        records.where(attr_name.to_sym => keyword)
      elsif [DateTime, Time].include?(data_type)
        records.where(attr_name.to_sym => keyword.to_date.beginning_of_day..keyword.to_date.end_of_day)
      else
        records.where(attr_name.to_sym => /#{keyword}/)
      end
    end
  end
end
