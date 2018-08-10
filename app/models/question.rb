class Question < ApplicationRecord
  extend FriendlyId
  include PgSearch
  belongs_to :user
  has_many :likes, as: :target
  has_many :likers, through: :likes, source: :user
  has_many :answers, dependent: :destroy
  has_many :question_categories, foreign_key: :question_id, dependent: :destroy
  has_many :categories, through: :question_categories, source: :major
  scope :order_desc, ->{order updated_at: :desc}

  friendly_id :question_slug, use: :slugged

  pg_search_scope :search,
    against: [:title, :content],
    using: {
      tsearch: {
        prefix: true
      }
    }

  def add_like user
    likers << user
  end

  def question_slug
    return "#{content}##{id}" if content.split.size >
                                 Settings.question.slug_size
    "#{content.split[0...Settings.question.slug_size].join(" ")}##{id}"
  end

  def unlike user
    likers.delete user
  end

  def liked? user
    likers.include? user
  end
end
