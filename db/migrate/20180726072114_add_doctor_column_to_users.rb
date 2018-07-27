class AddDoctorColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :request_doctor, :boolean
    add_column :users, :doctor_activated, :boolean
  end
end
