class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :problem
      t.text :solution
      t.datetime :deadline

      t.timestamps
    end
  end
end
