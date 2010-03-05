class LineItem < ActiveRecord::Base
  
  # Relationships
  belongs_to :invoice
  
  # Validations
  validates_presence_of :description
  validates_presence_of :cost
  
  protected
  
  def after_save
    self.invoice.cost = self.invoice.cost + self.cost
  end
end
