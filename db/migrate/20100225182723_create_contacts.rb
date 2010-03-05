class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :account_id
      t.integer :contact_type_id
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :zip
      t.string :phone
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
