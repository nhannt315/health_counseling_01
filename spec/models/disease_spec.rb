require "rails_helper"
RSpec.describe Disease, type: :model do
  let!(:category) {create(:major)}
  let!(:disease) {create(:disease, category: category)}
  describe "validations" do
    it {validate_presence_of :name}
    it {validate_presence_of :content_html}
  end

  describe "associations" do
    it {is_expected.to belong_to :category}
  end

  describe "instance method" do
    it "disease slug" do
      expect(disease.disease_slug).to eq(disease_slug disease.name, disease.id)
    end
  end
end
