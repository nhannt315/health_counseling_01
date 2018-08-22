class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages:#{current_user.id}"
  end

  def unsubscribed; end
end
