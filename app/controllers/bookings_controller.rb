class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def create
    doctor = Doctor.find_by id: params[:booking][:doctor_id]
    @booking = doctor.schedules.build booking_params
    return if @booking.save
  end

  def update
    @booking = Booking.find_by id: params[:id]
    @booking.update_attributes start_time: params[:booking][:start_time],
      stop_time: params[:booking][:stop_time]
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @booking = Booking.find_by id: params[:id]
    if @booking.destroy
      respond_to do |format|
        format.js
      end
    else
      flash.now[:warning] = t "global.messages.cant_delete_booking"
    end
  end

  private

  def booking_params
    params.require(:booking).permit :doctor_id, :user_id, :title,
      :start_time, :stop_time, :category_id, :location,
      :state, :accept, :schedule_type, :reason
  end
end
