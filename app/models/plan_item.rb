class PlanItem < ActiveRecord::Base
  
  # Relationships
  belongs_to :plan
  belongs_to :billable_item
  
  # Verifications
  validates_presence_of :plan
  validates_presence_of :billable_item
end
