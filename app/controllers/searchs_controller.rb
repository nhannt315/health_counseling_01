class SearchsController < ApplicationController
  before_action :fetch_questions, only: [:index]

  def index
    respond_to do |format|
      format.html
      format.json do
        render json: @questions.map do |question|
          {
            id: question.id,
            suggest: question.content.truncate(Settings.home.suggest_text_len),
            link: question_url(question), content: question.content
          }
        end
      end
    end
  end

  def show; end

  private

  def fetch_questions
    return unless params[:query]
    @questions = Question.search(params[:query])
                         .limit(Settings.home.suggest_limit)
  end
end
