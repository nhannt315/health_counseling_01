class Booking < ApplicationRecord
  belongs_to :user, class_name: User.name, foreign_key: :user_id
  belongs_to :doctor, class_name: Doctor.name, foreign_key: :doctor_id
  belongs_to :category, class_name: Major.name, foreign_key: :category_id
end
