class DiseasesController < ApplicationController
  def index
    @diseases = Disease.exclude_content.name_asc.group_by do |item|
      item.name.parameterize.upcase[0]
    end
    @diseases = @diseases.to_a
  end

  def show
    @disease = Disease.friendly.find_by slug: params[:id]
    return if @disease
    flash[:message] = t "error.page_not_found"
    render "shared/404"
  end
end
