module ConversationsHelper
  def load_current_conversations
    return if session[:conversations].nil?
    @conversations = Conversation.includes(:receiver, :messages)
                                 .find_by id: session[:conversations]
  end
end
