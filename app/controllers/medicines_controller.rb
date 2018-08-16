class MedicinesController < ApplicationController
  def show
    @medicine = Medicine.friendly_id.find_by slug: params[:id]
    return if @medicine
    flash[:message] = t "error.page_not_found"
    render "shared/404"
  end
end
