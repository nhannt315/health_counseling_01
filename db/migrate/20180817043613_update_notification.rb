class UpdateNotification < ActiveRecord::Migration[5.2]
  def change
    change_column :notifications, :read, :boolean, default: false
    change_column :notifications, :checked, :boolean, default: false
    change_table :notifications do |t|
      t.remove :question_id
      t.remove :major_id
      t.remove :notification_type
      t.references :notifiable, polymorphic: true, index: true
    end
  end
end
