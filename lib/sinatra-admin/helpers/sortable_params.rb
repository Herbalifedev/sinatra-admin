module SinatraAdmin
  module SortableParams
    def url_query_string attribute, sort_attr, sort_by
      url_query_str = params
      if url_query_str.has_key?("sort")
        url_query_str['sort'] = (sort_attr.eql?(attribute) && sort_by.eql?("desc")) ? "#{attribute} asc" : "#{attribute} desc"
      else
        url_query_str = url_query_str.merge({sort: (sort_by.eql?("desc")) ? "#{attribute} asc" : "#{attribute} desc"})
      end
      url_query_str.to_query
    end
  end
end