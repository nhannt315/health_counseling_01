class ApplicationController < ActionController::Base
  before_action :set_locale
  include UsersHelper

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = I18n.t "sessions.new.required"
    redirect_to login_url
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
