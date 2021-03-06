class CreateUserPreferences < ActiveRecord::Migration
  def self.up
    create_table :user_preferences do |t|
      t.integer :account_id
      t.string :key
      t.string :value
      t.timestamps
    end
  end

  def self.down
    drop_table :user_preferences
  end
end
