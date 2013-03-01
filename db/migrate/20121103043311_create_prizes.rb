class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string :name
      t.boolean :segregate

      t.timestamps
    end

    add_column :tasks, :prize_id, :integer
  end
end
