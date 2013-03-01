class AddReferencesUserToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :owner_id, :integer
    add_column :tasks, :organization_id, :integer
  end
end
