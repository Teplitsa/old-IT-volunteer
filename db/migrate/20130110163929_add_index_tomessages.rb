class AddIndexTomessages < ActiveRecord::Migration
  def up
    add_index :messages, [:dialog_id, :sender_id]
    add_index :messages, [:dialog_id, :receiver_id]

    # CREATE INDEX messages_receiver_id_with_id_eq_dialog_idx ON messages(receiver_id) WHERE id = dialog_id;

    execute <<-SQL
      CREATE INDEX messages_sender_id_with_id_eq_dialog_idx ON messages(sender_id) WHERE id = dialog_id;
    SQL
  end

  def down
    drop_index :messages, [:dialog_id, :sender_id]
    drop_index :messages, [:dialog_id, :receiver_id]
    
    # DROP INDEX IF EXISTS messages_receiver_id_with_id_eq_dialog_idx;

    execute <<-SQL
      DROP INDEX IF EXISTS messages_sender_id_with_id_eq_dialog_idx;
    SQL
  end
end
