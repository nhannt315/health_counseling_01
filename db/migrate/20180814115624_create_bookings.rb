class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.string :title
      t.integer :user_id
      t.integer :doctor_id
      t.integer :category_id
      t.datetime :start_time
      t.datetime :stop_time
      t.boolean :accept
      t.string :reason
      t.string :state
      t.string :location
      t.string :schedule_type

      t.timestamps
    end
  end
end
