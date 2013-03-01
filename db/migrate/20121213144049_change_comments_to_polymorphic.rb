class ChangeCommentsToPolymorphic < ActiveRecord::Migration
  def up
    rename_column :comments, :task_id, :owner_id
    remove_column :comments, :user_id
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
  end

  def down
    rename_column :comments, :owner_id, :user_id
    add_column :comments, :user_id, :integer
    remove_column :comments, :commentable_id
    remove_column :comments, :commentable_type
  end
end
