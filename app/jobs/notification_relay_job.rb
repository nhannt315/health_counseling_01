class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform notification
    html = ApplicationController.render partial: "notifications/notification",
      locals: {notification: notification}, format: [:html]
    ActionCable.server.broadcast "notifications:#{notification.receiver_id}",
      html: html
  end
end
