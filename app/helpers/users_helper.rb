module UsersHelper
  def user_avatar user
    user.avatar.url || Settings.default.avatar
  end
end
