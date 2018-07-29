class Admin::BaseController < ApplicationController
  layout "admin/index"
  before_action :admin_required
  include SessionsHelper

  protected

  def admin_required
    return if current_user&.admin?
    redirect_to root_url
  end
end
