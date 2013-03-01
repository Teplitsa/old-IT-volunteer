class RemoveExtOrganizationColumns < ActiveRecord::Migration
  def change
    remove_column :organizations, :property_type
    remove_column :organizations, :inn
    remove_column :organizations, :kpp
    remove_column :organizations, :is_group
  end
end
