class Notification < ApplicationRecord
  enum notification_type: {doctor_noti: 0, user_noti: 1}
  belongs_to :receiver, class_name: User.name, foreign_key: :receiver_id
  belongs_to :sender, class_name: User.name, foreign_key: :sender_id
  belongs_to :question
  belongs_to :major

  after_create_commit :broadcast_notification

  def content
    if doctor_noti?
      I18n.t "notification.doctor_noti", major_name: major.name,
        asker_name: sender.name
    else
      I18n.t "notification.user_noti", name: sender.name
    end
  end

  def url
    Rails.application.routes.url_helpers.question_path question.id
  end

  private

  def broadcast_notification
    NotificationRelayJob.perform_later self
  end
end
