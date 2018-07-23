class Notification < ApplicationRecord
  enum notification_type: {doctor_noti: 0, user_noti: 1}
  belongs_to :user
end
