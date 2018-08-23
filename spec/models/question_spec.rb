require "rails_helper"

RSpec.describe Question, type: :model do
  describe "validations" do
    it "content must not be nil" do
      user = FactoryBot.build(:user)
      user.skip_confirmation!
      user.save
      question = FactoryBot.create(:question, user: user)
      expect(question.content).not_to be nil
    end
  end
  describe "associations" do
    it {should belong_to :user}
    it {should have_many :categories}
  end
end
