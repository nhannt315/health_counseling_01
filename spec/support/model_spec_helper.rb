module ModelSpecHelper
  def email_slug email, id
    "#{email.gsub(/@[a-z\d\-.]+\.[a-z]+\z/, '')} #{id}"
  end

  def medicine_slug name, id
    "#{name} #{id}"
  end

  def disease_slug name, id
    "#{name}##{id}"
  end

  def doctor_noti_content notifiable
    I18n.t "notification.doctor_noti",
      major_name: notifiable.major.name,
      asker_name: notifiable.question.user.name
  end

  def user_noti_content notifiable
    I18n.t "notification.user_noti", name: notifiable.user.name
  end

  def user_noti_answer_content notifiable
    I18n.t "notification.answer_noti", name: notifiable.user.name
  end
end
