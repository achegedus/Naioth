class Contact < ActiveRecord::Base
  
  # Relationships
  belongs_to  :account, :dependent => :delete
  has_one     :contact_type
  
  
  # Validations
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :company
  validates_presence_of :address1
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :country
  validates_presence_of :email
  
end
