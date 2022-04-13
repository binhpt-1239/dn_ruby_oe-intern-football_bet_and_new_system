require "rails_helper"
include SessionsHelper

RSpec.describe BetsController, type: :controller do
  describe "GET index" do
    let!(:user){FactoryBot.create :user}
    let!(:match){FactoryBot.create :soccer_match}
    context "when logged in" do
      before do
        log_in user
        get :index, params: {match_id: match.id}
      end

      it "render index template" do
        expect(response).to render_template :index
      end

      it "check match" do
        expect(assigns(:match)).to eq(match)
      end
    end

    context "when match not found" do
      before do
        log_in user
        get :index, params: {match_id: -1}
      end

      it "flag warning" do
        expect(flash[:warning]).to eq I18n.t("bets.index.not_found_match")
      end

      it "redirect to root_path" do
        expect(response).to redirect_to root_path
      end
    end

    context "when not login" do
      before do
        get :index, params: {match_id: match.id}
      end

      it_behaves_like "redirect to path", "root_path"
    end

    context "when search ransack" do
      let!(:bet){Bet.create!(soccer_match_id: match.id, rate: 4, bet_type: 4, content: "Score: 0-0")}
      before do
        log_in user
        get :index, params: {q: {match_id: match.id, content_cont: "0-0"}}
      end

      it "assigns bets constant bet" do
        expect(assigns(:bets)).to eq([bet])
      end
    end
  end
end
