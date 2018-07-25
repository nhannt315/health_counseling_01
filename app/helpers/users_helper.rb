module UsersHelper
  def user_avatar user
    return Settings.default.avatar unless user.avatar
    user.avatar
  end
end
