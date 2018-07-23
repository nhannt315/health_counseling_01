class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.references :category, foreign_key: true
      t.boolean :checked
      t.integer :type

      t.timestamps
    end
  end
end
