class AddIgnoredToUser < ActiveRecord::Migration

  def change
    add_column :users, :ignored_users, :integer_array
  end

end
