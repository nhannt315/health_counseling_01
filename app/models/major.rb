class Major < ApplicationRecord
  has_many :doctor_majors
  has_many :doctors, through: :doctor_majors, source: :user
  has_many :question_categories, foreign_key: :major_id, dependent: :destroy
  has_many :questions, through: :question_categories
end
