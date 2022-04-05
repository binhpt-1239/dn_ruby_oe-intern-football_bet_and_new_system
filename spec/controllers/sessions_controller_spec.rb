require "rails_helper"
include SessionsHelper

RSpec.describe SessionsController, type: :controller do

  describe "GET new" do
    before {get :new}
    it "render new template" do
      expect(response).to render_template :new
    end
  end

  describe "Post Create" do
    let!(:invalid_attribute){{session: {email: nil, password: nil, remember_me: 0}}}

    context "when admin logged in success" do
      let!(:admin_user){FactoryBot.create :user}
      let!(:admin_valid_attribute){{session: {email: admin_user.email, password: admin_user.password, remember_me: 0}}}

      before do
        post :create, params: admin_valid_attribute
      end

      it "set session user" do
        expect(session[:user_id]).to eq admin_user.id
      end
      it "delete cookie user_id" do
        expect(cookies[:user_id]).to be_nil
      end
      it "delete cookie remember_token" do
        expect(cookies[:remember_token]).to be_nil
      end
      it "redirect to admin_root_path" do
        expect(response).to redirect_to admin_root_url
      end
      it "flag success" do
        expect(flash[:success]).to eq I18n.t("notification.log_in.success")
      end
    end

    context "when client logged in success" do
      let!(:client_user){FactoryBot.create :client_user}
      let!(:client_valid_attribute){{session: {email: client_user.email, password: client_user.password, remember_me: 1}}}

      before do
        post :create, params: client_valid_attribute
      end

      it "set session user" do
        expect(session[:user_id]).to eq client_user.id
      end
      it "remember cookie user_id" do
        expect(cookies.signed[:user_id]).to be client_user.id
      end
      it "remember cookie remember_token" do
        expect(cookies.signed[:remember_token]).to be client_user.remember_token
      end
      it "redirect to admin_root_path" do
        expect(response).to redirect_to root_url
      end
      it "flag success" do
        expect(flash[:success]).to eq I18n.t("notification.log_in.success")
      end
    end

    context "when logged in fails" do
      before do
        post :create, params: invalid_attribute
      end

      it "flag danger" do
        expect(flash[:danger]).to eq I18n.t("notification.log_in.err")
      end
      it "render new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "DELETE destroy" do
    context "when logged in" do
      let!(:user){FactoryBot.create :user}

      before do
        log_in user
        remember user
        get :destroy
      end

      it "delete session user" do
        expect(session[:user_id]).to be_nil
      end
      it "delete cookie user_id" do
        expect(cookies[:user_id]).to be_nil
      end
      it "delete cookie remember_token" do
        expect(cookies[:remember_token]).to be_nil
      end
      it "delete current user" do
        expect(assigns(:current_user)).to be_nil
      end
      it "flag success" do
        expect(flash[:success]).to eq I18n.t("notification.log_in.out_success")
      end
      it "redirect to root_url" do
        expect(response).to redirect_to root_url
      end
    end

    context "when not logged in" do
      before do
        delete :destroy
      end

      it "redirect to root_url" do
        expect(response).to redirect_to root_url
      end
    end
  end
end
