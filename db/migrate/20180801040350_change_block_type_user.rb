class ChangeBlockTypeUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :blocked, :block_status
    change_column :users, :block_status, 'integer USING CAST(block_status AS integer)'
  end
end
