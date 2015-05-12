class Purchase < ActiveRecord::Base
  has_and_belongs_to_many(:products)

  scope(:between, lambda {|start_date, end_date| where("created_at >= ? AND created_at <= ?", start_date, end_date )})
end
