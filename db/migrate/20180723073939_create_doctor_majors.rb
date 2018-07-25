class CreateDoctorMajors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctor_majors do |t|
      t.references :users, foreign_key: true
      t.references :major

      t.timestamps
    end
  end
end
