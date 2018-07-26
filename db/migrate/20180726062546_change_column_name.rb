class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :doctor_majors, :users_id, :user_id
    rename_column :answers, :users_id, :user_id
    rename_column :questions, :users_id, :user_id
    rename_column :notifications, :users_id, :user_id
  end
end
