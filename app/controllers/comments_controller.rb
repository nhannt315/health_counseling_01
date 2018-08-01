class CommentsController < ApplicationController
  before_action :check_login, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = Answer.new comment_params

    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      flash[:warning] = t ".unsucess"
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @rawcomment.update_attributes content: params[:comments][:content]
      respond_to do |format|
        format.js
      end
      flash[:warning] = t ".sucess"
    else
      flash[:warning] = t ".unsucess"
    end
  end

  def destroy
    if @rawcomment.delete
      respond_to do |format|
        format.js
      end
      flash[:warning] = t ".sucess"
    else
      flash[:warning] = t ".unsucess"
    end
  end

  private
  def comment_params
    params.require(:comments)
          .permit :content, :user_id, :question_id
  end

  def check_login
    return if logged_in?
    flash[:warning] = t "global.message.please_login_action"
    redirect_to questions_path
  end

  def find_comment
    @rawcomment = Answer.find_by id: params[:id]
    redirect_to questions_path unless @rawcomment.present?
  end
end
