class DoctorsController < ApplicationController
  before_action :find_doctor, only: [:show, :update, :edit]

  def show
    majors = @doctor.majors
    if majors.empty?
      @left_col = []
      @right_col = []
    else
      @left_col, @right_col = majors.each_slice((majors.size / 2.0).round).to_a
    end
    @questions = @doctor.questions
  end

  def edit
    @all_majors = Major.pluck :name, :id
    @current_majors = @doctor.major_ids
  end

  def update
    @doctor.update_attributes doctor_params
    major_ids = params[:doctor][:majors]
    major_ids.shift
    @doctor.add_majors major_ids
  end

  private

  def find_doctor
    @doctor = Doctor.find_by id: params[:id]
    return if @doctor
    flash[:message] = I18n.t "error.user_not_found"
    render "shared/404"
  end

  def doctor_params
    params.require(:doctor).permit :name, :email, :phone_number,
      :address, :prof_position, :bio, :license, :identity_card, :avatar,
      :prof_place
  end
end
