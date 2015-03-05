module SinatraAdmin
  module SortableParamsHelper
    extend self

    def url_query_string url_params, attribute, sort_attr, sort_by
      if url_params.has_key?("sort")
        url_params['sort'] = (sort_attr.eql?(attribute) && sort_by.eql?("desc")) ? "#{attribute} asc" : "#{attribute} desc"
      else
        url_params = url_params.merge({sort: (sort_by.eql?("desc")) ? "#{attribute} asc" : "#{attribute} desc"})
      end
      url_params.to_query
    end

    def get_sort_attr_and_sort_by sort
      sort.blank? ? default_sort : sort.split(" ")
    end

    def default_sort
      %w(created_at desc)
    end

    def sorting_symbol direction
      direction.eql?("asc") ? '&uarr;' : '&darr;'
    end
  end
end