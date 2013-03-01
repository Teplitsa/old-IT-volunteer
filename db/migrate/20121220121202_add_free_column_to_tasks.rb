class AddFreeColumnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :is_free, :boolean
  end
end
