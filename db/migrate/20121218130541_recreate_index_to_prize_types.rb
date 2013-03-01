class RecreateIndexToPrizeTypes < ActiveRecord::Migration
  def change
    remove_index :task_prizes, [:prize_type_id, :task_id]
    add_index :task_prizes, :task_id    
  end
end
