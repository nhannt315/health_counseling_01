class Notifications::AnswerReplyService
  def initialize answer
    @answer = answer
  end

  def perform
    notification_targets(@answer).each do |target_user|
      notification = Notification.new sender_id: @answer.user.id,
        receiver_id: target_user.id, notifiable_id: @answer.id,
        notifiable_type: Answer.name
      NotificationRelayJob.perform_later notification if notification.save
    end
  end

  private

  def notification_targets answer
    ([answer.question.user] +
      answer.question.commented_users.to_a - [answer.user]).uniq
  end
end
