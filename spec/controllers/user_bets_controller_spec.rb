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
      it_behaves_like "flash danger message", "notification.log_in.request"
      it_behaves_like "redirect to path", "login_path"
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

      it_behaves_like "flash danger message", "notification.log_in.request"
      it_behaves_like "redirect to path", "login_path"
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

    context "when user not logged in" do
      before :each do
        get :index
      end

      it_behaves_like "flash danger message", "notification.log_in.request"
      it_behaves_like "redirect to path", "login_path"
    end
  end
end
