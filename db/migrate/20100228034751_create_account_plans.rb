class CreateAccountPlans < ActiveRecord::Migration
  def self.up
    create_table :account_plans do |t|
      t.integer :account_id
      t.integer :plan_id
      t.date    :start_date
      t.timestamps
    end
  end

  def self.down
    drop_table :account_plans
  end
end
