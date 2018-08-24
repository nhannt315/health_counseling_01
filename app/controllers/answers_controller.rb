class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @answer = Answer.new answer_params
    if @answer.save
      respond_to do |format|
        format.js
      end
    else
      flash[:warning] = t ".unsucess"
    end
  end

  def destroy
    @answer = Answer.find_by id: params[:id]
    unless @answer
      flash[:message] = t "error.page_not_found"
      render "shared/404"
      return
    end
    redirect_to root_url unless @answer.user.current_user? current_user
    if @answer
      @answer.delete
    else
      flash[:warning] = t ".cant_delete"
    end
  end

  private

  def answer_params
    params.require(:answer).permit :content, :user_id, :question_id
  end
end
