require "rails_helper"

RSpec.describe QuestionsController, type: :controller do
  let!(:user){create(:user)}
  let!(:question) {create(:question, user: user)}
  describe "#index" do
    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end
  end
  describe "#create" do
    let(:category) {create(:major)}
    let(:attr) do
      {
        content: Faker::Lorem.sentence,
        category_ids: [category.id]
      }
    end
    it "render index after creating question" do
      sign_in user
      post :create, params: {question: attr}
      expect(response).to render_template :index
    end
  end
  describe "#show" do
    it "responds successfully" do
      get :show, params: {id: question.slug}
      expect(response).to be_successful
    end

    it "redirect to index if question not exists" do
      get :show, params: {id: question.id}
      expect(response).to redirect_to questions_url
    end
  end
  describe "#destroy" do
    it "responds successfully and with status 200" do
      sign_in user
      delete :destroy, params: {id: question.slug}
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
end
