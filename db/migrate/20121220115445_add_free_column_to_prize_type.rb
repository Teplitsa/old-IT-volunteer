class AddFreeColumnToPrizeType < ActiveRecord::Migration
  def change
    add_column :prize_types, :is_free, :boolean
  end
end
