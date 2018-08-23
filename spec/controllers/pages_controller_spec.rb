require "rails_helper"

RSpec.describe PagesController, type: :controller do
  describe "#home" do
    it "responds successfully" do
      get :show, params: {page: "home"}
      expect(response).to be_successful
    end
  end
  describe "#about" do
    it "responds successfully" do
      get :show, params: {page: "about"}
      expect(response).to be_successful
    end
  end
  describe "#list" do
    it "responds successfully" do
      get :show, params: {page: "list"}
      expect(response).to be_successful
    end
  end
  describe "#privacy" do
    it "responds successfully" do
      get :show, params: {page: "privacy"}
      expect(response).to be_successful
    end
  end
  describe "#term" do
    it "responds successfully" do
      get :show, params: {page: "term"}
      expect(response).to be_successful
    end
  end
end
