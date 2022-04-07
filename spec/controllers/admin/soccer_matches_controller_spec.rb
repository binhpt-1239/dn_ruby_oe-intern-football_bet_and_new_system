require "rails_helper"
include SessionsHelper

RSpec.describe Admin::SoccerMatchesController, type: :controller do
  describe "GET #index" do
    let!(:user) { create(:user)}
    let!(:currency_1){user.currencies.create(amount: 70, currency_type_id: :win)}
    let!(:currency_2){user.currencies.create(amount: 100, currency_type_id: :lose)}
    context "when user logged in" do
      before do
        log_in user
        get :index
      end

      it "should has soccer matches" do
        expect(assigns(:soccer_matches)).not_to be_nil
      end

      it "should has total win" do
        expect(assigns(:win)).to eq 70
      end

      it "should has total lose" do
        expect(assigns(:lose)).to eq 100
      end
    end

    it_behaves_like "when not logged in admin"
  end

  describe "GET #new" do
    let!(:user) { create(:user)}
    let!(:soccer_match) { SoccerMatch.new }
    context "when user logged in" do
      before do
        log_in user
        get :new
      end

      it "should has soccer matches" do
        expect(assigns(:soccer_match)).not_to be_nil
      end

      it_behaves_like "#load_teams_and_tournaments"
    end

    it_behaves_like "when not logged in admin"
  end

  describe "GET #edit" do
    let!(:user) { create(:user)}
    let!(:soccer_match) { create(:soccer_match) }
    context "when user logged in" do
      before :each do
        log_in user
        get :edit, params: { id: soccer_match.id}
      end

      it_behaves_like "#load_teams_and_tournaments"
      it_behaves_like "has soccer match"
      it_behaves_like "has no soccer match", "get", "edit"
    end

    it_behaves_like "when not logged in admin"
  end

  describe "GET #show" do
    let!(:user) { create(:user)}
    context "when user logged in" do
      let!(:soccer_match) { create(:soccer_match) }
      let!(:bet_1){soccer_match.bets.create(rate: 1, bet_type: 1, content: "Two Home win")}
      let!(:bet_2){soccer_match.bets.create(rate: 0.9, bet_type: 2, content: "Two Team draw")}
      let!(:user_bet_1){user.user_bets.create(amount: 70, bet_id: bet_1.id, result_bet: 0)}
      let!(:user_bet_2){user.user_bets.create(amount: 100, bet_id: bet_2.id, result_bet: 1)}
      before do
        log_in user
        get :show, params: { id: soccer_match.id }
      end

      it "check total_amount" do
        expect(assigns(:total_amount)).to eq(170)
      end

      it "check total money user lose has rate" do
        expect(assigns(:total_winner_has_rate)).to eq(90)
      end

      it "check total money user lose" do
        expect(assigns(:total_lose_amount)).to eq(70)
      end

      it_behaves_like "has soccer match"
      it_behaves_like "has no soccer match", "get", "show"
    end

    it_behaves_like "when not logged in admin"
  end

  describe "POST #create" do
    let!(:user) { create(:user)}
    context "when user logged in" do
      let!(:soccer_match) { create(:soccer_match) }
      before do
        log_in user
        post :create, params: { soccer_match: {home_id: 1, team_id: 2,
                                               time: Time.now, tournament_id: 1}}
      end

      it "check soccer_match" do
        expect(assigns(:soccer_match)).not_to be_nil
      end

      context "save successful" do
        before :each do
          post :create, params: { soccer_match: {home_id: 1, team_id: 2,
            time: Time.now, tournament_id: 1}}
        end

        it_behaves_like "flash success message", "admin.soccer_matches.create.successful_create"
        it_behaves_like "redirect to path", "new_admin_soccer_match_path"
      end

      context "save failed" do
        before :each do
          allow_any_instance_of(SoccerMatch).to receive(:save).and_return(false)
          post :create, params: { soccer_match: {home_id: 1, team_id: 2,
            time: Time.now, tournament_id: 1}}
        end
        it_behaves_like "flash now danger message", "admin.soccer_matches.create.failure_create"
        it_behaves_like "render action template", "new"
      end
    end

    it_behaves_like "when not logged in admin"
  end

  describe "PUT #update" do
    let!(:user) { create(:user)}
    context "when user logged in" do
      let!(:soccer_match) { create(:soccer_match) }
      before do
        log_in user
        post :update, params: { id: soccer_match.id, soccer_match: {home_id: 1, team_id: 2,
                                                                    time: Time.now, tournament_id: 1} }
      end

      it "check soccer_match" do
        expect(assigns(:soccer_match)).to eq soccer_match
      end

      context "update successful" do
        before :each do
          post :update, params: { id: soccer_match.id, soccer_match: {home_id: 1, team_id: 2,
                                                                      time: Time.now, tournament_id: 1} }
        end

        it_behaves_like "flash success message", "admin.soccer_matches.update.successful_update"
        it_behaves_like "redirect to path", "admin_root_path"
      end

      context "save failed" do
        before :each do
          allow_any_instance_of(SoccerMatch).to receive(:update).and_return(false)
          post :update, params: { id: soccer_match.id, soccer_match: {home_id: 1, team_id: 2,
                                                                      time: Time.now, tournament_id: 1} }
        end

        it_behaves_like "flash now danger message", "admin.soccer_matches.update.failure_update"
        it_behaves_like "render action template", "edit"
      end
    end

    it_behaves_like "when not logged in admin"
  end
end
