class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show]
  before_action :logged_in_user,
    only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index; end

  def show; end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".user_updated"
      redirect_to @user
    else
      flash[:warning] = t ".user_update_failed"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user)
          .permit :name, :email, :password, :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:message] = I18n.t "error.user_not_found"
    render "shared/404"
  end

  def correct_user
    redirect_to root_url unless @user.current_user? current_user
  end

  def request_doctor_check
    params[:user][:request_doctor] == "1"
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:success] = t "global.auth.login_please"
    redirect_to login_url
  end
end
