class AddReceiverIdToNotification < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :user_id, :sender_id
    add_column :notifications, :receiver_id, :integer
  end
end
