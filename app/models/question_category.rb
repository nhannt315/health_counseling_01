class QuestionCategory < ApplicationRecord
  belongs_to :question
  belongs_to :major

  after_create_commit :notify

  private

  def notify
    major.doctors.each do |doctor|
      Notification.create sender_id: question.user.id, receiver_id: doctor.id,
        question_id: question.id, major_id: major.id,
        checked: false, read: false,
        notification_type: Notification.notification_types[:doctor_noti]
    end
  end
end
