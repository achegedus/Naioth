class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.integer         :account_id
      t.integer         :invoice_number
      t.date            :date
      t.string          :state
      t.string          :url
      t.string          :external
      t.integer         :cost
      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
