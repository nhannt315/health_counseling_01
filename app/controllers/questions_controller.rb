class QuestionsController < ApplicationController
  before_action :fetch_data, only: [:index, :create, :destroy]

  def index; end

  def create
    new_question = current_user.questions.build question_params
    if new_question.save
      new_question.category_ids = params[:question][:category_ids]
      flash[:success] = t ".created"
    else
      flash[:warning] = t ".error"
    end
    render :index
  end

  def destroy
    del_question = current_user.questions.find_by id: params[:id]
    if logged_in? && del_question.present?
      flash[:success] = del_question.destroy ? t(".deleted") : t(".error")
    else
      flash[:warning] = t "global.login_require"
    end
    render :index
  end

  private

  def question_params
    params.require(:question).permit :content, :category_ids
  end

  def fetch_data
    @question = current_user.questions.build if logged_in?
    @majors = Major.pluck :name, :id
    unless params[:major_id]
      return @question_feeds = Question.order(created_at: :desc)
                                       .page(params[:page])
    end
    raw_major = Major.find_by id: params[:major_id]
    @question_feeds = raw_major.questions.page params[:page]
  end
end
