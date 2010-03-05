class AccountPlan < ActiveRecord::Base
  
  # Relationships
  belongs_to :account
  belongs_to :plan
  
  # Verifications
  
end
