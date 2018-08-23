require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let!(:user) {create(:user)}
  let!(:user_temp){create(:user)}
  describe "#show" do
    it "response successfully" do
      get :show, params: {id: user.slug}
      expect(response).to be_successful
    end
  end

  describe "#edit" do
    it "response successfully" do
      sign_in user
      get :edit, params: {id: user.slug}
      expect(response).to be_successful
    end

    it "return a 200 response" do
      sign_in user
      get :edit, params: {id: user.slug}
      expect(response).to have_http_status "200"
    end

    it "redirect to login page if not signed in and have status 302" do
      get :edit, params: {id: user.slug}
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_url
    end

    it "redirect to home page if not correct user and have status 302" do
      sign_in user_temp
      get :edit, params: {id: user.slug}
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_url
    end
  end

  describe "#update" do
    let(:attr) do
      {name: Faker::Name}
    end
    it "redirects to user detail page upon update successfully" do
      sign_in user
      post :update, params: {id: user.slug, user: attr}
      expect(response).to redirect_to user_url user
    end
  end
end
