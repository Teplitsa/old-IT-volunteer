class AddIndexToPrizeTypes < ActiveRecord::Migration
  def change
    add_index :task_prizes, [:prize_type_id, :task_id]
  end
end
