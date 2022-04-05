require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  describe "GET home" do
    it "render home" do
      get :home
      expect(response).to render_template(:home)
    end
  end
  describe "GET help" do
    it "render help" do
      get :help
      expect(response).to render_template(:help)
    end
  end
  describe "GET about" do
    it "render about" do
      get :about
      expect(response).to render_template(:about)
    end
  end
end
