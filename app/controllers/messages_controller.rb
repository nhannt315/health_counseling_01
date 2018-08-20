class MessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:receiver).find(params[:conversation_id])
    @message = @conversation.messages.build message_params
    if @message.save
      MessageRelayJob.perform_later(@message, current_user)
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :content)
  end
end
