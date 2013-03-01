class AddImageToPrize < ActiveRecord::Migration
  def change
    add_column :prizes, :image, :string
  end
end
