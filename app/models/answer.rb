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
    Notification.create sender_id: user.id, receiver_id: question.user.id,
      question_id: question.id, major_id: question.categories.first,
      checked: false, read: false,
      notification_type: Notification.notification_types[:user_noti]
  end
end
