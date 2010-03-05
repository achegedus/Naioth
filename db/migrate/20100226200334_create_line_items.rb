class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.integer         :invoice_id
      t.string          :description
      t.integer         :cost
      t.timestamps
    end
  end

  def self.down
    drop_table :line_items
  end
end
