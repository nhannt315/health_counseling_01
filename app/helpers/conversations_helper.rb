module ConversationsHelper
  def load_current_conversations
    @conversations = Conversation.includes(:receiver, :messages)
      .find(session[:conversations]) if session[:conversations] != nil
  end
end
