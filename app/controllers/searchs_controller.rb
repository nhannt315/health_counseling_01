class SearchsController < ApplicationController
  def index
    if params[:query]
      @questions = Question.search(params[:query])
                           .limit(Settings.home.suggest_limit)
    end
    respond_to do |format|
      format.html
      format.json do
        render json: @questions.map{|question|
          {
            id: question.id,
            suggest: question.content.truncate(Settings.home.suggest_text_len),
            link: question_url(question), content: question.content
          }}
      end
    end
  end

  def show; end
end
