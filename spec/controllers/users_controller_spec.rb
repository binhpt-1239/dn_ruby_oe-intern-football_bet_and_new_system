require "rails_helper"
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    let!(:user) { create(:user)}

    context "when user logged in" do
      before do
        log_in user
        get :show, params: { id: user.id }
      end
      it "render show template" do
        expect(response).to render_template(:show)
      end
    end

    context "when user not logged in" do
      before do
        get :show, params: {id: user.id}
      end

      it_behaves_like "redirect to path", "root_path"
    end
  end
end
