class AddAuthProviderUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.integer :provider, default: 0
      t.string :uid
    end
  end
end
