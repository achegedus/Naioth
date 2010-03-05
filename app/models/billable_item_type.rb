class BillableItemType < ActiveRecord::Base
  
  # Relationships
  belongs_to :billable_item
  
  # Validations
  validates_presence_of :name
  
end
