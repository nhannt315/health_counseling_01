require "rails_helper"

RSpec.describe DoctorsController, type: :controller do
  let!(:doctor) {create(:user, type: :Doctor)}
  describe "#show" do
    it "response successfully and has status 200" do
      get :show, params: {id: doctor.slug}
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "#edit" do
    it "response successfully and has status 200" do
      sign_in doctor
      get :edit, params: {id: doctor.slug}
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end

    it "render error template when doctor not found" do
      sign_in doctor
      get :edit, params: {id: doctor.id}
      expect(response).to render_template "shared/404"
    end

    let!(:doctor_temp){create(:user, type: :Doctor)}
    it "redirect to home page if not correct user and have status 302" do
      sign_in doctor_temp
      get :edit, params: {id: doctor.slug}
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_url
    end
  end

  describe "#update" do
    let(:major) {create(:major)}
    let(:attr) do
      {
        name: Faker::Name.name,
        majors: ["", major.id]
      }
    end
    it "redirect to doctor detail page after updating successfully" do
      sign_in doctor
      patch :update, params: {id: doctor.slug, doctor: attr}
      expect(response).to redirect_to doctor_path doctor
    end
  end
end
