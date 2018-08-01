module UsersHelper
  def user_avatar user
    user.avatar.url || Settings.default.avatar
  end

  def doctor_info doctor, field_name
    doctor.send(field_name).url || Settings.default.doctor_image
  end
end
