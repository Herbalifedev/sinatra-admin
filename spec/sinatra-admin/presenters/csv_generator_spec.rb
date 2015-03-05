require 'spec_helper'
require 'csv'

describe SinatraAdmin::Presenters::CsvGenerator do

  describe 'export_csv' do
    let(:collections) { [{'username' => "user-1", 'first_name' => "first-1", 'last_name' => "last-1"}, {'username' => "user-2", 'first_name' => "first-2", 'last_name' => "last-2"}] }
    let(:attributes) { ['username', 'first_name', 'last_name'] }
    
    it 'should toggle sorting direction' do
      result = SinatraAdmin::Presenters::CsvGenerator.new(collections, attributes).export_csv
      array_collections = collections.map{|h| h.values}
      expect(result).to eq("#{attributes.join(',')}\n#{array_collections.first.join(',')}\n#{array_collections.last.join(',')}\n")
    end
  end
end