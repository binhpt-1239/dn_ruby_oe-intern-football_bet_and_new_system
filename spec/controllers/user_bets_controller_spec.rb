require "rails_helper"
include SessionsHelper

RSpec.describe UserBetsController, type: :controller do
  describe "GET #new" do
    let!(:user) { create(:user)}
    let!(:bet) { create(:bet) }
    context "when user logged in" do
      before do
        log_in user
      end

      context "when has bet" do
        it "load bet" do
          get :new, params: { id: bet.id }
          expect(assigns(:bet)).to eq(bet)
        end
      end

      context "when has not bet" do
        before :each do
          get :new, params: { id: -1 }
        end

        it_behaves_like "flash warning message", "user_bets.new.not_found_bet"
        it_behaves_like "redirect to path", "root_path"
      end
    end

    context "when user not logged in" do
      before :each do
        get :new, params: { id: bet.id }
      end
      it_behaves_like "redirect to path", "root_path"
    end
  end

  describe "POST #create" do
    let!(:user) { create(:user)}
    let!(:user_bet) { create(:user_bet) }
    let!(:bet) { create(:bet) }

    context "when user logged in" do
      before do
        log_in user
      end

      context "money bet valid" do
        before{
          user.currencies.create! amount: 10000, currency_type_id: :payment
        }

        before :each do
          post :create, params: {id: bet.id, user_bet: {amount: 1000}}
        end

        it "create currency" do
          expect(assigns(:current_user).currencies).not_to be_nil
        end

        it "create user bet" do
          expect(assigns(:current_user).user_bets).not_to be_nil
        end

        context "save success" do
          before :each do
            post :create, params: {id: bet.id, user_bet: {amount: 1000, bet_id: bet.id}}
          end

          it_behaves_like "flash success message", "user_bets.create.success"
          it_behaves_like "redirect to path", "root_path"
        end

        context "save fails" do
          before :each do
            allow_any_instance_of(User).to receive(:save!).and_raise(StandardError)
            post :create, params: {id: bet.id, user_bet: {amount: 1000, bet_id: bet.id}}
          end

          it_behaves_like "flash warning message", "user_bets.create.fails"
          it_behaves_like "redirect to path", "root_path"
        end
      end

      context "money bet invalid" do
        before :each do
          post :create, params: {id: bet.id, user_bet: {amount: 15000}}
        end

        it_behaves_like "flash warning message", "user_bets.create.amount_invalid"
        it_behaves_like "redirect to path", "new_user_bet_path"
      end
    end

    context "when user not logged in" do
      before :each do
        post :create, params: {id: bet.id, user_bet: {amount: 100}}
      end

      it_behaves_like "redirect to path", "root_path"
    end
  end

  describe "GET #index" do
    let!(:user) { create(:user)}
    let!(:user_bets) { user.user_bets }

    context "when user logged in" do
      before do
        log_in user
      end

      it "check user_bets" do
        get :index
        expect(assigns(:user_bets)).to eq(user_bets)
      end
    end

    it_behaves_like "when do not have access", "index"

    context "when search ransack" do
      let!(:home_team){FactoryBot.create :home_team}
      let!(:guest_team){FactoryBot.create :guest_team}
      let!(:soccer_match){SoccerMatch.create(tournament_id: 1, time: Time.now + 1.day,
                                            home_id: home_team.id, guest_id: guest_team.id, status: 1)}
      let!(:bet){soccer_match.bets.create(rate: 0.9, bet_type: 2, content: "Two Team draw")}
      let!(:user_bet){user.user_bets.create(amount: 100000, bet_id: bet.id)}
      before do
        log_in user
        get :index, params: {q: {match_id: soccer_match.id, amount_gteq: 100000}}
      end

      it "assigns user_bets constant user_bet" do
        expect(assigns(:user_bets)).to eq([user_bet])
      end
    end
  end
end
