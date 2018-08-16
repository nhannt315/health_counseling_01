class MedicineTypesController < ApplicationController
  def show
    @medicine_type = MedicineType.friendly_id.find_by slug: params[:id]
    unless @medicine_type
      flash[:message] = t "medicine_types.show.error"
      render "shared/404"
    end
    @medicines = @medicine_type.medicines.page(params[:page])
                               .per(Settings.medicine.per_page)
  end
end
