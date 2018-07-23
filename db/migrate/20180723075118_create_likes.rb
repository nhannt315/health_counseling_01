class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :target_id
      t.string :target_type

      t.timestamps
    end
  end
end
