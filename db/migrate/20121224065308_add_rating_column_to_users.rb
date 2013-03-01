class AddRatingColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rating, :integer, null: false, default: 0
  end
end
