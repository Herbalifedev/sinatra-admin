require 'spec_helper'

describe SinatraAdmin::SortableParamsHelper do

  describe 'url_query_string' do
    context 'when params sort found' do
      let(:url_params) { {'sort' => "_id desc", 'page' => 2} }

      it 'should toggle sorting direction' do
        result = SinatraAdmin::SortableParamsHelper.url_query_string(url_params, '_id', '_id', 'desc')
        expect(result).to include("sort=_id+asc")
      end
    end

    context 'when params sort isnt found' do
      let(:url_params) { {'page' => 2} }

      it 'should toggle sorting direction' do
        result = SinatraAdmin::SortableParamsHelper.url_query_string(url_params, '_id', '_id', 'asc')
        expect(result).to include("sort=_id+desc")
      end
    end
  end

  describe 'get_sort_attr_and_sort_by' do
    context 'when sort equal to username asc' do
      it 'should return username asc' do
        result = SinatraAdmin::SortableParamsHelper.get_sort_attr_and_sort_by('username asc')
        expect(result).to eq(["username", "asc"])
      end
    end

    context 'when sort equal to nil' do
      it 'should return created_at desc' do
        result = SinatraAdmin::SortableParamsHelper.get_sort_attr_and_sort_by(nil)
        expect(result).to eq(["created_at", "desc"])
      end
    end
  end

  describe 'default_sort' do
    it 'should return created_at desc' do
      result = SinatraAdmin::SortableParamsHelper.default_sort
      expect(result).is_a?(Array)
      expect(result).to eq(["created_at", "desc"])
    end
  end

  describe 'sorting_symbol' do
    context 'when sort asc' do
      it 'should return arrow up' do
        result = SinatraAdmin::SortableParamsHelper.sorting_symbol('asc')
        expect(result).to eq("&uarr;")
      end
    end

    context 'when sort desc' do
      it 'should return arrow down' do
        result = SinatraAdmin::SortableParamsHelper.sorting_symbol('desc')
        expect(result).to eq("&darr;")
      end
    end
  end
end