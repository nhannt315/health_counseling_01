class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :likes, as: :target
  has_many :likers, through: :likes, source: :user

  after_create_commit :notify

  def add_like user
    likers << user
  end

  def unlike user
    likers.delete user
  end

  def liked? user
    likers.include? user
  end

  private

  def notify
    Notifications::AnswerReplyService.new(self).perform
  end
end
