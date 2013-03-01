class RemoveStatusFromTask < ActiveRecord::Migration
  def up
    remove_column :tasks, :status
  end
end
