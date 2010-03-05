class CreatePlanItems < ActiveRecord::Migration
  def self.up
    create_table :plan_items do |t|
      t.integer :plan_id
      t.integer :billable_item_id
      t.integer :allowance
      t.timestamps
    end
  end

  def self.down
    drop_table :plan_items
  end
end
