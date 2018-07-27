class AddRecommendToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :recommend, :boolean
  end
end
