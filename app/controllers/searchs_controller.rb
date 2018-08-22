class SearchsController < ApplicationController
  before_action :fetch_questions, :fetch_diseases, :fetch_medicines,
    only: [:index]

  def index
    respond_to do |format|
      format.html
      format.json do
        render_result @questions, @medicines, @diseases
      end
    end
  end

  def show; end

  private

  def render_result questions, medicines, diseases
    render json: {
      questions: {
        title: I18n.t("questions.index.name"),
        results: questions.map do |question|
          {
            id: question.id,
            suggest: question.content.truncate(Settings.home.suggest_text_len),
            link: question_url(question), content: question.content
          }
        end
      },
      diseases: {
        title: I18n.t("diseases.name"),
        results: diseases.map do |disease|
                   {
                     id: disease.id,
                     suggest: disease.name,
                     link: disease_url(disease)
                   }
                 end
      },
      medicines: {
        title: I18n.t("medicines.name"),
        results: medicines.map do |medicine|
                   {
                     id: medicine.id,
                     suggest: medicine.name,
                     link: medicine_url(medicine)
                   }
                 end
      }
    }
  end

  def fetch_diseases
    return unless params[:query]
    @diseases = Disease.search(params[:query])
                       .limit(Settings.home.suggest_limit)
  end

  def fetch_medicines
    return unless params[:query]
    @medicines = Medicine.search(params[:query])
                         .limit(Settings.home.suggest_limit)
  end

  def fetch_questions
    return unless params[:query]
    @questions = Question.search(params[:query])
                         .limit(Settings.home.suggest_limit)
  end
end
