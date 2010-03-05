class ContactType < ActiveRecord::Base
  
  # Relationships
  belongs_to    :contact
  
  # Validations
  validates_presence_of :name
  
end
