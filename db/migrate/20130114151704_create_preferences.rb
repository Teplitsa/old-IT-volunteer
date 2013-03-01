class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :user_id
      t.integer :preferenceble_id
      t.string  :preferenceble_type
      
      t.timestamps
    end
  end
end
