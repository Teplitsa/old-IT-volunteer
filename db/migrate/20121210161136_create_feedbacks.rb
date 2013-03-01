class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :user
      t.references :task
      t.integer :value
      t.string :body

      t.timestamps
    end
    add_index :feedbacks, :user_id
    add_index :feedbacks, :task_id
  end
end
