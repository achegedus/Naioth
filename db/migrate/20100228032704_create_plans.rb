class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.string  :description
      t.string  :code
      t.integer :cost

      t.timestamps
    end
  end

  def self.down
    drop_table :plans
  end
end
