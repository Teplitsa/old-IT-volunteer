class AddStateToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :state, :integer
  end
end
