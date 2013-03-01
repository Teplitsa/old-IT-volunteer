class AddStatusToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :status, :string, :default => 'pending'
    add_index :tasks, :status
  end
end
