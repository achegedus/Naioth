class UserPreference < ActiveRecord::Base
  
  # Relationships
  belongs_to :account
  
  # Validations
  
end
