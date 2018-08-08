class LikesController < ApplicationController
  before_action :logged_in_user,:fetch_target, only: [:create, :destroy]

  def create
    @target.add_like current_user
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @target.unlike current_user
    respond_to do |format|
      format.js
    end
  end

  private

  def fetch_target
    @target = if params[:type] == Settings.questions
                Question.find_by id: params[:target_id]
              else
                Answer.find_by id: params[:target_id]
              end
    return if @target.present?
    show_error
  end

  def show_error
    flash.now[:message] = I18n.t "error.something_happened"
    respond_to do |format|
      format.js{render "shared/alert"}
    end
  end
end
