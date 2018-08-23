require "rails_helper"

RSpec.describe MedicineType, type: :model do
  let!(:medicine_class) {create(:medicine_class)}
  let!(:medicine_type) {create(:medicine_type)}
  let!(:medicine_type) do create(:medicine_type,
    medicine_class_id: medicine_class.id)
  end
  describe "associations" do
    it {is_expected.to have_many :medicines}
    it {is_expected.to belong_to :medicine_class}
  end

  describe "validations" do
    it {validate_presence_of :name}
  end
end
