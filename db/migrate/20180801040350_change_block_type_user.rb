class ChangeBlockTypeUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :blocked, :block_status
    change_column :users, :block_status, :integer
  end
end
