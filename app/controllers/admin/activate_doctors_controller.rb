class Admin::ActivateDoctorsController < Admin::BaseController
  def create
    @doctor = Doctor.find_by id: params[:doctor_id]
    @doctor&.activate
    respond_to do |format|
      format.html{redirect_to @doctor}
      format.js
    end
  end
end
