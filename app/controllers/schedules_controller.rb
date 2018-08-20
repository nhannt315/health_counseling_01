class SchedulesController < ApplicationController
  def index
    @doctor = Doctor.find_by id: params[:id]
  end

  def create

  end
end
