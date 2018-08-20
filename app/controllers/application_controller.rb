class ApplicationController < ActionController::Base
  before_action :set_locale
  include UsersHelper
  include MedicinesHelper
  include ConversationsHelper

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = I18n.t "sessions.new.required"
    redirect_to login_url
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
