class Admin::DoctorsController < Admin::BaseController
  before_action :find_doctor, only: [:show, :update]

  def index
    @doctors = Doctor.search(params[:search]).page(params[:page])
                     .per Settings.admin.item_per_page
  end

  def show
    unless @doctor
      flash[:message] = I18n.t "error.user_not_found"
      return render "shared/404"
    end
    majors = @doctor.majors
    if majors.empty?
      @left_col = []
      @right_col = []
    else
      @left_col, @right_col = majors.each_slice((majors.size / 2.0).round).to_a
    end
  end

  def update
    respond_to do |format|
      if params[:type] == Settings.admin.doctor.activate
        @doctor&.activate
        format.js{render "admin/doctors/activate"}
      else
        format.html
      end
    end
  end

  private

  def find_doctor
    @doctor = Doctor.find_by id: params[:id]
  end
end
