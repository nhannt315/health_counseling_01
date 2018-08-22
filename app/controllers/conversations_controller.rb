class ConversationsController < ApplicationController
  def create
    @conversation = Conversation.get params[:conversation][:sender_id],
      params[:conversation][:receiver_id]
    add_to_conversations unless conversated?
  end

  def destroy; end

  def close
    @conversation = Conversation.find(params[:id])
    session[:conversations].delete(@conversation.id)
  end

  private

  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations]&.include? @conversation.id
  end
end
