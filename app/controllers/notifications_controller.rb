class NotificationsController < ApplicationController
  def update
    notification = Notification.find_by id: params[:id]
    unless notification
      render status: 404, json: {
        message: "Not found!"
      }
    end
    notification.read = true
    notification.save
  end

  def mark_all_as_checked
    user = User.find_by id: params[:id]
    unless current_user == user
      render status: 403, json: {
        message: "Unauthorized request!"
      }
      return
    end
    user.notifications.find_each do |notification|
      notification.checked = true
      notification.save
    end
    render status: 200, json: {
      message: "Complete!"
    }
  end
end
