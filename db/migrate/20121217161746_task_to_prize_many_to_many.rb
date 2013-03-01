class TaskToPrizeManyToMany < ActiveRecord::Migration
  def up
    rename_table :prizes, :prize_types

    create_table :task_prizes do |t|
      t.integer :task_id
      t.integer :prize_type_id
      t.integer :count
    end
  end

  def down
    drop_table :task_prizes
    rename_table :prize_types, :prizes
  end
end
