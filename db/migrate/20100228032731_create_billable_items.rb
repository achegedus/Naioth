class CreateBillableItems < ActiveRecord::Migration
  def self.up
    create_table :billable_items do |t|
      t.string  :billable_item_type_id, :default => 1
      t.string  :name
      t.string  :description
      t.timestamps
    end
  end

  def self.down
    drop_table :billable_items
  end
end
