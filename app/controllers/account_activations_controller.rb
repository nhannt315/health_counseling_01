class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user&.authenticated?(:activation, params[:id]) && !user.activated?
      active_and_login user
      return redirect_to edit_doctor_url(user) if user.request_doctor
      redirect_to user
    else
      flash[:danger] = I18n.t "activate_mail.fail"
      redirect_to root_url
    end
  end

  private

  def active_and_login user
    user.activate
    log_in user
    flash[:success] = I18n.t "activate_mail.success"
  end
end
