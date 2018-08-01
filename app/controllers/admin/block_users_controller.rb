class Admin::BlockUsersController < Admin::BaseController
  before_action :find_user

  def create
    @user&.block
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user&.unblock
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def find_user
    @user = User.find_by id: params[:user_id]
  end
end
