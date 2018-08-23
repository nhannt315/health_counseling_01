require "rails_helper"

RSpec.describe MedicineClass, type: :model do
  let!(:medicine_class) {create(:medicine_class)}
  describe "associations" do
    it {is_expected.to have_many :medicine_types}
  end

  describe "validations" do
    it {validate_presence_of :name}
  end
end
