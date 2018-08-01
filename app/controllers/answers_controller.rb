class AnswersController < ApplicationController
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

    if @answer
      @answer.delete
    else
      flash[:warning] = t ".cant_delete"
    end
  end

  private

  def answer_params
    params.require(:answer) .permit :content, :user_id, :question_id
  end
end
