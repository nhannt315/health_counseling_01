class SchedulesController < ApplicationController
  def index
    @doctor = Doctor.friendly.find_by slug: params[:doctor_id]
  end

  def create

  end
end
