class Invoice < ActiveRecord::Base
  
  # Relationships
  belongs_to :account
  has_many :line_items, :dependent => :destroy
  
  # Validations
  validates_presence_of :date
  # validates_presence_of :status
  validates_presence_of :cost
  
  # States
  state_machine :state, :initial => :created do
    event :email do
      transition :created => :sent
    end

    event :receive do
      transition :sent => :received
    end

    event :pay do
      transition :received => :paid
    end
  end
  
  def initialize
    super()
  end
  
  protected
  
  def before_create
    inum = SystemPreferences.find_by_key("invoice_number")
    self.invoice_number = inum.value.to_i
    inum.value = (inum.value.to_i + 1).to_s
    inum.save
  end
  
end