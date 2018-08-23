require "rails_helper"

RSpec.describe Question, type: :model do
  describe "validations" do
      user = FactoryBot.build :user
      user.skip_confirmation!
      user.save
      question = FactoryBot.build :question, user: user
    it "content must not be nil" do
      validate_presence_of :content
    end
    it "title must not be nil" do
      validate_presence_of :title
    end
    it "title must be at least #{Settings.test.question.title_min} characters length" do
      expect(question.title.length).to be >= Settings.test.question.title_min
    end
  end
  describe "associations" do
    it {should belong_to :user}
    it {should have_many :categories}
  end
end
