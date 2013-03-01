class RenameUsersIgnoredColumn < ActiveRecord::Migration
  def up
    rename_column :users, :ignored_users, :ignored_users_ids
  end
end
