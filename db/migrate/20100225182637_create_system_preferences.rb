class CreateSystemPreferences < ActiveRecord::Migration
  def self.up
    create_table :system_preferences do |t|
      t.string :key
      t.string :value
      t.timestamps
    end
    
    SystemPreferences.new(:key => "invoice_number", :value => "1000")
  end

  def self.down
    drop_table :system_preferences
  end
end
