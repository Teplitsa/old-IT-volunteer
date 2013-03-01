class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.references :user
      t.string :slug
      t.string :name
      t.string :property_type
      t.string :inn
      t.string :kpp
      t.string :email
      t.string :website
      t.string :skype
      t.string :twitter
      t.string :facebook
      t.string :linkedin
      t.string :logo
      t.text :about
      t.boolean :verified, :null => false, :default => false
      t.boolean :is_group, :null => false, :default => false

      t.timestamps
    end
  end
end
