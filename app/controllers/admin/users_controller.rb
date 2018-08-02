class Admin::UsersController < Admin::BaseController
  def index
    @users = User.search(params[:search]).page(params[:page])
                 .per Settings.admin.per_page
  end

  def show
    @user = User.find_by id: params[:id]
    @questions = @user.questions.page(Settings.default_page)
                      .per Settings.admin.per_page
    @answers = @user.answers.page(Settings.default_page)
                    .per Settings.admin.per_page
  end

  def update
    @user = User.find_by id: params[:id]
    respond_to do |format|
      case params[:type]
      when Settings.admin.block
        @user&.blocked!
        format.js{render "admin/users/unblock"}
      when Settings.admin.unblock
        @user&.non_block!
        format.js{render "admin/users/block"}
      else
        format.html
      end
    end
  end
end
