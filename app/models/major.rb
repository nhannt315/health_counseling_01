class Major < ApplicationRecord
  has_many :doctor_majors
  has_many :doctors, through: :doctor_majors
  has_many :question_categories
  has_many :questions, through: :question_categories
end
