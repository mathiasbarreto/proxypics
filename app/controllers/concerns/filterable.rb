module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(params)
      results = self.where(nil) # create an anonymous scope
      
      params.each do |key, value|
        if key == :date
          results = results.public_send("filter_by_#{key}", value[:start_date], value[:end_date]) if value.present?
        else
          results = results.public_send("filter_by_#{key}", value) if value.present?
        end
      end
      results
    end
  end
end