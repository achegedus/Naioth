class BillableItem < ActiveRecord::Base
  
  # Relationships
  has_one :billable_item_type
  
  has_many :plan_items, :dependent => :destroy
  has_many :plans, :through => :plan_items
  
  # Validations
  validates_presence_of :billable_item_type
  validates_presence_of :name
end
