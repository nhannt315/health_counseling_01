require "rails_helper"

RSpec.describe AnswersController, type: :controller do
  let!(:user) {create(:user)}
  describe "#create" do
    let!(:question) {create(:question, user: user)}
    let(:attr) do
      {
        content: Faker::Lorem.sentence,
        user_id: user.id,
        question_id: question.id
      }
    end
    context "as an authenticated user" do
      before do
        sign_in user
        post :create, xhr: true, params: {answer: attr}
      end
      it "response successfully" do
        expect(response).to be_successful
      end

      it "return 204 status" do
        expect(response).to have_http_status "204"
      end
    end

    context "as a guest" do
      it "return 401 status" do
        post :create, xhr: true, params: {answer: attr}
        expect(response).to have_http_status "401"
      end
    end
  end

  describe "#destroy" do
    let!(:answer) {create(:answer, user: user)}
    context "as an authenticated user" do
      before do
        sign_in user
      end
      it "return status 204 upon deleting successfully" do
        delete :destroy, params: {id: answer.id}
        expect(response).to have_http_status "204"
      end
      it "return 404 page if id not exist" do
        delete :destroy, params: {id: answer.content}
        expect(response).to render_template "shared/404"
      end
      context "current user doesn't own the answer" do
        before do
          delete :destroy, params: {id: create(:answer, user_id: create(:user).id)}
        end
        it "return 302 status" do
          expect(response).to have_http_status "302"
        end
        it "redirect to root url" do
          expect(response).to redirect_to root_url
        end
      end
    end

    context "as a guest" do
      it "return 302 status" do
        delete :destroy, params: {id: answer.id}
        expect(response).to have_http_status "302"
      end
    end
  end
end
