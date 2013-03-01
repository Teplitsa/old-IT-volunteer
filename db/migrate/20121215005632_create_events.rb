class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.references :actor,  :polymorphic => true
      t.references :target, :polymorphic => true
      t.references :user
      t.string :action
      t.string :message

      t.timestamps
    end
    add_index :events, :target_id
    add_index :events, :user_id
  end
end
