module SinatraAdmin
  module DataTableHelper
    extend self
 
    def dt_json (model)

      records = dt_source(model)
      recordsTotal = records.count
      
      records = dt_order(model, records)
      records = dt_filter(model, records)
      recordsFiltered = records.count
      
      records = dt_limit(records)

      data = []
      records.each do |r|
        item = {}
        model.attribute_names.each do |attr|
          item[attr] = r[attr]
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

    def dt_order (model, records)
      params[:order].each do |order|
        cIdx = order[1]['column'].to_i
        cDir = order[1]['dir'].to_sym
        attr = model.attribute_names[cIdx].to_sym
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

    def dt_source (model)
      if params[:order].count > 0
        records = model.unscoped.all
      else
        records = model.all
      end
      records
    end

    #
    # ~ Filters ---------------------------------------------------------------- 
    #
    
    def dt_filter (model, records)
      params[:columns].each do |column|
        attr     = column[1]['data']
        search   = column[1]['search']['value'].strip
        next if search.blank?
        

        attrType = model.fields[attr].type 
        
        if attrType == String || attrType == Moped::BSON::ObjectId || attrType == Object
          records = dt_filter_string(model, records, attr, search)
        elsif attrType == Integer || attrType == Float
          records = dt_filter_number(model, records, attr, search)
        elsif attrType == Boolean
          records = dt_filter_boolean(model, records, attr, search)
        elsif attrType == Time
          records = dt_filter_time(model, records, attr, search)
        else
          puts "I don't know how to filter this type: #{attrType}"
        end
      end

      records
    end
    
    def dt_filter_operator (match_op)
      case match_op
        when '<'
          operator = '$lt'
        when '>'
          operator = '$gt'
        when '>='
          operator = '$gte'
        when '<='
          operator = '$lte'
        else
          operator = '$eq'
      end
      operator
    end

    def dt_filter_apply (records, operator, selector1, selector2)
      case operator
        when '&&', 'and'
          records = records.and(selector1, selector2)
        when '||', 'or'
          records = records.or(selector1, selector2)
      end
      records
    end

    def dt_filter_number_selector (model, attr, operator, value) 
      model.unscoped.where(attr => { dt_filter_operator(operator) => value }).selector 
    end

    def dt_filter_number (model, records, attr, search)
      match = /^([><=]=?)?\s*(-?\d+(\.\d+)?)(\s*(or|and|\|\||&&)\s*([><=]=?)?\s*(-?\d+(\.\d+)?))?$/.match(search)
      return records unless match
      
      selector1 = dt_filter_number_selector(model, attr, match[1], match[2])
      if match[4]
        selector2 = dt_filter_number_selector(model, attr, match[6], match[7])
        records   = dt_filter_apply(records, match[5], selector1, selector2)
      else
        records   = records.where(selector1)         
      end
      records
    end

    def dt_filter_string (model, records, attr, search)
      records = records.where(attr => /#{search}/i) unless search.blank?
      records
    end

    def dt_filter_boolean (model, records, attr, search)
      value = (/^(true|t|yes|y|1)$/i =~ search) ? true: false
      records = records.where(attr => value);
      records
    end

    def dt_filter_date_selector (model, attr, operator, date)
      model.unscoped.where(attr => { dt_filter_operator(operator) => date}).selector
    end

    def dt_filter_time (model, records, attr, search)
      match = /^([><]?=?)?\s*(\d{4}-\d{2}-\d{2})(\s*(or|and|\|\||&&)([><]?=?)?\s*(\d{4}-\d{2}-\d{2}))?$/.match(search)
      return records unless match
      
      selector1 = dt_filter_date_selector(model, attr, match[1], match[2])
      if (match[3])
        selector2 = dt_filter_date_selector(model, attr, match[5], match[6])
        records = dt_filter_apply(records, match[4], selector1, selector2)
      else
        records = records.where(selector1)
      end
      records
    end
  end
end
