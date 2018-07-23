class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :phone_number
      t.string :remember_digest
      t.string :activation_digest
      t.string :password_digest
      t.datetime :activated_at
      t.string :reset_digest
      t.boolean :admin
      t.string :avatar
      t.string :type
      t.string :prof_place
      t.string :prof_spec
      t.string :identity_card
      t.string :license
      t.string :info_confirmed
      t.string :bio
      t.string :prof_position
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
