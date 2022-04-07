require "rails_helper"
include SessionsHelper
include SoccerMatchHelper

RSpec.describe Admin::UserBetsController, type: :controller do
  describe "GET index" do
    let!(:user) {create(:user)}
    let!(:user_bet){user.user_bets.create(amount: 100, bet_id: bet.id)}
    let!(:home_team){FactoryBot.create :home_team}
    let!(:guest_team){FactoryBot.create :guest_team}
    let!(:soccer_match){SoccerMatch.create(tournament_id: 1, time: Time.now + 1.day,
                                          home_id: home_team.id, guest_id: guest_team.id, status: 1)}
    let!(:bet){soccer_match.bets.create(rate: 0.9, bet_type: 2, content: "Two Team draw")}

    context "success when valid params" do
      before do
        log_in user
        get :index, params: {match_id: soccer_match.id}
      end

      it "assigns all user_bets as @user_bets" do
        expect(assigns(:user_bets)).to eq([user_bet])
      end
      it_behaves_like "render action template", "index"
    end

    it_behaves_like "when admin not logged in", "index"

    it_behaves_like "when logged in but not admin", "index"

    context "when match not found" do
      before do
        log_in user
        get :index, params: {match_id: -1}
      end

      it_behaves_like "flash warning message", "admin.user_bets.not_found_match"
      it_behaves_like "redirect to path", "admin_root_path"
    end

    context "when bet not found" do
      before do
        log_in user
        get :index, params: {match_id: soccer_match.id, score: true}
      end

      it_behaves_like "flash warning message", "admin.user_bets.not_found_bet"
      it_behaves_like "redirect to path", "admin_root_path"
    end

    context "when match not begin" do
      let!(:match_unbegin){SoccerMatch.create(tournament_id: 1, time: Time.now + 1.day,
                                            home_id: home_team.id, guest_id: guest_team.id, status: 0)}
      let!(:bet_2){match_unbegin.bets.create(rate: 0.9, bet_type: 2, content: "Two Team draw")}
      before do
        log_in user
        get :index, params: {match_id: match_unbegin.id}
      end

      it_behaves_like "flash warning message", "admin.user_bets.match_not_begin"
      it_behaves_like "redirect to path", "admin_root_path"
    end
  end
end
