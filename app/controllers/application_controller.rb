class ApplicationController < ActionController::Base
  before_action :set_locale
  include SessionsHelper
  include UsersHelper

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
