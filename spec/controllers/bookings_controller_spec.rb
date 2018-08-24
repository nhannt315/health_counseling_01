require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  let!(:user) {create(:user)}
  let!(:attr) {FactoryBot.attributes_for(:booking)}
  describe "#create" do
    context "as an authenticated user" do
      before do
        sign_in user
        post :create, xhr: true, params: {booking: attr}
      end
      it "return 200 status upon created successfully" do
        expect(response).to have_http_status "200"
      end
      it "render js template upon created successfully" do
        expect(response).to render_template "bookings/create"
      end
    end

    context "as a guest" do
      before {post :create, xhr: true, params: {booking: attr}}
      it "return 401 status" do
        expect(response).to have_http_status "401"
      end
    end
  end

  describe "#update" do
    let!(:booking) {create(:booking)}
    context "as an authenticated user" do
      before do
        sign_in user
        put :update, xhr: true, params: {id: booking.id, booking: attr}
      end
      it "return 200 status upon updated successfully" do
        expect(response).to have_http_status "200"
      end
      it "render js template upon updated successfully" do
        expect(response).to render_template "bookings/update"
      end
    end

    context "as a guest" do
      before {put :update, xhr: true, params: {id: booking.id, booking: attr}}
      it "return 401 status" do
        expect(response).to have_http_status "401"
      end
    end
  end

  describe "#destroy" do
    let!(:booking) {create(:booking)}
    context "as an authenticated user" do
      before do
        sign_in user
        delete :destroy, xhr: true, params: {id: booking.id}
      end
      it "return 200 status upon updated successfully" do
        expect(response).to have_http_status "200"
      end
      it "render js template upon updated successfully" do
        expect(response).to render_template "bookings/destroy"
      end
    end

    context "as a guest" do
      before {delete :destroy, xhr: true, params: {id: booking.id}}
      it "return 401 status" do
        expect(response).to have_http_status "401"
      end
    end
  end
end
