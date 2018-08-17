class Notification < ApplicationRecord
  belongs_to :receiver, class_name: User.name, foreign_key: :receiver_id
  belongs_to :sender, class_name: User.name, foreign_key: :sender_id
  belongs_to :notifiable, polymorphic: true

  def content
    if notifiable_type == QuestionCategory.name
      I18n.t "notification.doctor_noti",
        major_name: notifiable.major.name,
        asker_name: notifiable.question.user.name
    elsif notifiable.question.user == receiver
      I18n.t "notification.user_noti",
        name: notifiable.user.name
    else
      I18n.t "notification.answer_noti",
        name: notifiable.user.name
    end
  end

  def url
    if notifiable_type == Answer.name
      Rails.application.routes.url_helpers.question_path notifiable.question
    else
      Rails.application.routes.url_helpers.question_path notifiable
    end
  end
end
