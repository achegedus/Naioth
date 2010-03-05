class CreateContactTypes < ActiveRecord::Migration
  def self.up
    create_table :contact_types do |t|
      t.string :name
      t.timestamps
    end
    
    ContactType.create :name => "Billing Address"
    ContactType.create :name => "Administrative Address"
  end

  def self.down
    drop_table :contact_types
  end
end
