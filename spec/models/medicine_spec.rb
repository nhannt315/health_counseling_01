require "rails_helper"

RSpec.describe Medicine, type: :model do
  let! (:medicine) {create(:medicine)}
  describe "associations" do
    it {is_expected.to belong_to :medicine_type}
  end

  describe "validations" do
    it {validate_presence_of :name}
    it {validate_presence_of :company}
    it {validate_presence_of :overview}
    it {validate_presence_of :instruction}
    it {validate_presence_of :info}
    it {validate_presence_of :warning}
    it {validate_presence_of :contraindication}
    it {validate_presence_of :side_effect}
    it {validate_presence_of :note}
    it {validate_presence_of :overdose}
    it {validate_presence_of :preservation}
  end

  describe "instance method" do
    it "medicine slug" do
      expect(medicine.medicine_slug).to eq(medicine_slug medicine.name, medicine.id)
    end
  end
end
