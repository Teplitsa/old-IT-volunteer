class AddOrgIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :organization_id, :integer
  end
end
