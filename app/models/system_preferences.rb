class SystemPreferences < ActiveRecord::Base
  
  # Validations
  validates_presence_of :key
  validates_presence_of :value
  validates_uniqueness_of :key
  
end
