class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform message, current
    html = ApplicationController.render partial: "messages/message2",
      locals: {message: message, current: current}, format: [:html]
    ActionCable.server.broadcast "messages:#{message.conversation.receiver_id}",
      html: html, conversation_id: message.conversation.id
  end
end
