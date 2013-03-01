class AddImageToTaskType < ActiveRecord::Migration
  def change
    add_column :task_types, :image, :string
  end
end