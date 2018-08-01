class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show]
  before_action :logged_in_user,
    only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def index; end

  def new
    redirect_to root_url if logged_in?
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.type = :Doctor if @user.request_doctor = request_doctor_check
    if @user.save
      @user.send_mail :account_activation
      @messages = [t("users.create.thank"), t("users.create.email_sent")]
      render "shared/confirm"
    else
      render :new
    end
  end

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
