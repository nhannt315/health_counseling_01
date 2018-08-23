class Notifications::QuestionNewService
  def initialize question_category
    @ques_cate = question_category
  end

  def perform
    @ques_cate.major.doctors.each do |target_user|
      notification = Notification.new sender_id: @ques_cate.question.user.id,
        receiver_id: target_user.id, notifiable_type: QuestionCategory.name,
        notifiable_id: @ques_cate.id
      NotificationRelayJob.perform_later notification if notification.save
    end
  end
end
