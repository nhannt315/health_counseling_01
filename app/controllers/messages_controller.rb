class MessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:receiver).find(params[:conversation_id])
    @message = @conversation.messages.build message_params
    if @message.save
      ActionCable.server.broadcast "messages",
        message: @message.content,
        user_id: @message.user.id,
        conversation: @message.conversation.id
      head :ok
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :content)
  end
end
