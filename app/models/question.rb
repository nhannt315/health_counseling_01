class Question < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :target
  has_many :answers, dependent: :destroy
  has_many :question_categories, dependent: :destroy
  has_many :categories, through: :question_categories
end
