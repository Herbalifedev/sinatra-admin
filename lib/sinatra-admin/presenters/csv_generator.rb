require 'csv'

module Presenters
  class CsvGenerator
    def initialize(collections, attributes)
      @collections = collections
      @attributes = attributes
    end
  
    def export_csv
      CSV.generate do |csv|
        csv << @attributes
        @collections.each do |item|
          row = []
          @attributes.each do |col|
            row << item[col]
          end
          csv << row
        end
      end
    end
  end
end