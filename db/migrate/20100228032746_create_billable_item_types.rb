class CreateBillableItemTypes < ActiveRecord::Migration
  def self.up
    create_table :billable_item_types do |t|
      t.string :name

      t.timestamps
    end
    
    BillableItemType.new(:name => "Flat Fee")
    BillableItemType.new(:name => "Block")
  end

  def self.down
    drop_table :billable_item_types
  end
end
