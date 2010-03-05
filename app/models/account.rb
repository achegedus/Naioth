class Account < ActiveRecord::Base

  # Relationships
  has_many  :contacts
  has_many  :invoices
  has_many  :account_plans
  has_many  :plans, :through => :account_plans
  has_many  :user_preferences, :dependent => :destroy
  
  accepts_nested_attributes_for :contacts, :allow_destroy => true
  attr_accessible :contacts_attributes
  
  attr_accessible :login, :password, :password_confirmation
  
  # Validations
  validates_presence_of :password
  validates_presence_of :password_confirmation
  validates_length_of   :password, :minimum => 4
  
  # States
  state_machine :state, :initial => :registered do
    event :activate do
      transition :registered => :current
    end
    
    event :invoice do
      transition :current => :invoiced
    end
    
    event :pay do
      transition [:invoiced, :overdue, :inactive] => :current
    end
    
    event :over do
      transition :invoiced => :overdue
    end
    
    event :deactivate do
      transition [:current, :invoiced, :overdue] => :inactive
    end
  end
  
  
  acts_as_authentic do |c|
    c.validates_length_of_password_field_options = {:on => :update, 
                                                    :minimum => 4, 
                                                    :if => :has_no_credentials?}
                                                    
    c.validates_length_of_password_confirmation_field_options = { :on => :update, 
                                                                  :minimum => 4, 
                                                                  :if => :has_no_credentials?}
  end
  
  def initialize
    super()
  end
  
  # we need to make sure that either a password or openid gets set
  # when the user activates his account
  def has_no_credentials?
    self.crypted_password.blank?
  end
  
  # ...
  # now let's define a couple of methods in the user model. The first
  # will take care of setting any data that you want to happen at signup
  # (aka before activation)
  def signup!(params)
    self.login = params[:account][:login]
    self.contacts[0].first_name = params[:account][:contacts_attributes]["0"][:first_name]
    self.contacts[0].last_name = params[:account][:contacts_attributes]["0"][:last_name]
    self.contacts[0].address1 = params[:account][:contacts_attributes]["0"][:address1]
    self.contacts[0].address2 = params[:account][:contacts_attributes]["0"][:address2]
    self.contacts[0].city = params[:account][:contacts_attributes]["0"][:city]
    self.contacts[0].state = params[:account][:contacts_attributes]["0"][:state]
    self.contacts[0].zip = params[:account][:contacts_attributes]["0"][:zip]
    self.contacts[0].email = params[:account][:contacts_attributes]["0"][:email]
    self.contacts[0].phone = params[:account][:contacts_attributes]["0"][:phone]
    self.contacts[0].company = params[:account][:contacts_attributes]["0"][:company]
    self.contacts[0].country = "US"
    self.password = params[:account][:password]
    self.password_confirmation = params[:account][:password_confirmation]
    save_without_session_maintenance
  end

  # the second will take care of setting any data that you want to happen
  # at activation. at the very least this will be setting active to true
  # and setting a pass, openid, or both.
  def activate!
    self.active = true
    save
  end
  
  def active?
    active
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end
  
end
