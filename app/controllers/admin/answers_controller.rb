class Admin::AnswersController < Admin::BaseController
  def index
    @answers = Answer.all.page(params[:page])
                     .per Settings.admin.per_page
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @answer = Answer.find_by id: params[:id]
    @is_success = @answer.destroy
    respond_to do |format|
      format.js
    end
  end
end
