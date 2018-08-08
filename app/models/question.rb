class Question < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :target
  has_many :likers, through: :likes, source: :user
  has_many :answers, dependent: :destroy
  has_many :question_categories, foreign_key: :question_id, dependent: :destroy
  has_many :categories, through: :question_categories, source: :major

  scope :order_desc, ->{order updated_at: :desc}

  def add_like user
    likers << user
  end

  def unlike user
    likers.delete user
  end

  def liked? user
    likers.include? user
  end
end
