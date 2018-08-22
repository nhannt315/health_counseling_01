class MessagesController < ApplicationController
  def create
    @conversation = Conversation.includes(:receiver)
                                .find(params[:conversation_id])
    @message = @conversation.messages.build message_params
    MessageRelayJob.perform_later(@message, current_user) if @message.save
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :content)
  end
end
