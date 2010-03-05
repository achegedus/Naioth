class Plan < ActiveRecord::Base
  
  # Relationships
  has_many :account_plans
  has_many :accounts, :through => :account_plans
  
  has_many :plan_items, :dependent => :destroy
  has_many :billable_items, :through => :plan_items
  
  # Validations
  validates_presence_of :cost
  validates_presence_of :description
end
