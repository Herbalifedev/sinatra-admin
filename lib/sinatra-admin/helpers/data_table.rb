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
            else
              row.send(assoc_key).each do |child|
                if item[assoc_key]
                  item[assoc_key].each_with_index do |out, assoc|
                    if assoc.has_value?(child.id)
                      out = out.push(assoc.merge({"_id" => child.id, "#{assoc_attr}" => child.send(assoc_attr)}))
                    else
                      out = out.push({"_id" => child.id, "#{assoc_attr}" => child.send(assoc_attr)})
                    end
                    item[assoc_key] = out
                  end
                  #out = []
                  #item[assoc_key].each do |assoc|
                  #  if assoc.has_value?(child.id)
                  #    out = out.push(assoc.merge({"_id" => child.id, "#{assoc_attr}" => child.send(assoc_attr)}))
                  #  else
                  #    out = out.push({"_id" => child.id, "#{assoc_attr}" => child.send(assoc_attr)})
                  #  end
                  #end
                  #item[assoc_key] = out
                else
                  item[assoc_key] = [{"_id" => child.id, "#{assoc_attr}" => child.send(assoc_attr)}]
                end
              end
            end
          else
            item[attr] = row[attr]
          end
        end
        data << item
      end
      p '======================== Records =============='
      p data

      {
        draw: params[:draw] ? params[:draw].to_i : 1,
        recordsTotal: recordsTotal,
        recordsFiltered: recordsFiltered,
        data: data
      }.to_json
    end

    def dt_order (records)
      params[:order].each do |order|
        cIdx = order[1]['column'].to_i
        cDir = order[1]['dir'].to_sym
        attr = @configure.attribute_names[cIdx].to_sym
        records = records.send(cDir, attr)
      end
      records
    end

    def dt_limit (records)
      if params[:start] && params[:length] != -1
        records = records.skip(params[:start].to_i).limit(params[:length])
      end
      records
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
      #params[:columns].each do |column|
      #  attr     = column[1]['data']
      #  search   = column[1]['search']['value'].strip
      #  next if search.blank?
      #  
      #
      #  attrType = @model.fields[attr].type 
      #  
      #  if attrType == String || attrType == Moped::BSON::ObjectId || attrType == Object
      #    records = dt_filter_string(records, attr, search)
      #  elsif attrType == Integer || attrType == Float
      #    records = dt_filter_number(records, attr, search)
      #  elsif attrType == Boolean
      #    records = dt_filter_boolean(records, attr, search)
      #  elsif attrType == Time
      #    records = dt_filter_time(records, attr, search)
      #  else
      #    puts "I don't know how to filter this type: #{attrType}"
      #  end
      #end
      #
      #records
    end
    
    #def dt_filter_operator (match_op)
    #  case match_op
    #    when '<'
    #      operator = '$lt'
    #    when '>'
    #      operator = '$gt'
    #    when '>='
    #      operator = '$gte'
    #    when '<='
    #      operator = '$lte'
    #    else
    #      operator = '$eq'
    #  end
    #  operator
    #end

    #def dt_filter_apply (records, operator, selector1, selector2)
    #  case operator
    #    when '&&', 'and'
    #      records = records.and(selector1, selector2)
    #    when '||', 'or'
    #      records = records.or(selector1, selector2)
    #  end
    #  records
    #end

    #def dt_filter_number_selector (attr, operator, value) 
    #  @model.unscoped.where(attr => { dt_filter_operator(operator) => value }).selector 
    #end

    #def dt_filter_number (records, attr, search)
    #  match = /^([><=]=?)?\s*(-?\d+(\.\d+)?)(\s*(or|and|\|\||&&)\s*([><=]=?)?\s*(-?\d+(\.\d+)?))?$/.match(search)
    #  return records unless match
    #  
    #  selector1 = dt_filter_number_selector(attr, match[1], match[2])
    #  if match[4]
    #    selector2 = dt_filter_number_selector(attr, match[6], match[7])
    #    records   = dt_filter_apply(records, match[5], selector1, selector2)
    #  else
    #    records   = records.where(selector1)         
    #  end
    #  records
    #end

    #def dt_filter_string (records, attr, search)
    #  records = records.where(attr => /#{search}/i) unless search.blank?
    #  records
    #end

    #def dt_filter_boolean (records, attr, search)
    #  value = (/^(true|t|yes|y|1)$/i =~ search) ? true: false
    #  records = records.where(attr => value);
    #  records
    #end

    #def dt_filter_date_selector (attr, operator, date)
    #  @model.unscoped.where(attr => { dt_filter_operator(operator) => date}).selector
    #end

    #def dt_filter_time (records, attr, search)
    #  match = /^([><]?=?)?\s*(\d{4}-\d{2}-\d{2})(\s*(or|and|\|\||&&)([><]?=?)?\s*(\d{4}-\d{2}-\d{2}))?$/.match(search)
    #  return records unless match
    #  
    #  selector1 = dt_filter_date_selector(attr, match[1], match[2])
    #  if (match[3])
    #    selector2 = dt_filter_date_selector(attr, match[5], match[6])
    #    records = dt_filter_apply(records, match[4], selector1, selector2)
    #  else
    #    records = records.where(selector1)
    #  end
    #  records
    #end

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
