class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.text    :title
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :closed, default: false

      t.timestamps
    end
    add_index :conversations, :sender_id
    add_index :conversations, :receiver_id
    add_index :conversations, [:receiver_id, :sender_id], unique: true
  end
end
