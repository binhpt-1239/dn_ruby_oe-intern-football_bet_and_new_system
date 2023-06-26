require 'rails_helper'
include SessionsHelper

RSpec.describe CurrenciesController, type: :controller do
  let!(:user) {create :user, admin: false}
  let(:params) {{currency: {currency_type_id: :withdrawal, amount: amount}}}
  let(:amount) {100}
  let(:currency_withdrawal) {Currency.withdrawal.newest.find_by(user_id: user.id)}

  describe "#create" do
    before {log_in user}

    context "when user is admin" do
      it do
        user.update_columns admin: true
        post :create, params: params

        expect(currency_withdrawal.amount).to eq amount #0
      end
    end

    context "when user is not admin" do
      context "time is holiday" do
        it do
          allow_any_instance_of(CurrenciesController).to receive(:holiday).and_return(true)
          post :create, params: params

          expect(currency_withdrawal.amount).to eq amount + 110 #110
        end
      end

      context "time is last week" do
        it do
          post :create, params: params

          expect(currency_withdrawal.amount).to eq amount + 110 #110
        end
      end

      context "time is week day" do
        before {allow_any_instance_of(CurrenciesController).to receive(:monday_to_friday).and_return(true)}

        it "Time from 00:00 - 7h44" do
          allow_any_instance_of(CurrenciesController).to receive(:morning).and_return(true)
          post :create, params: params

          expect(currency_withdrawal.amount).to eq amount + 110 #110
        end
        it "Time from 07:45 - 17h59" do
          allow_any_instance_of(CurrenciesController).to receive(:morning_evening).and_return(true)
          post :create, params: params

          expect(currency_withdrawal.amount).to eq amount #0
        end
        it "Time from 18:00 - 23:59" do
          allow_any_instance_of(CurrenciesController).to receive(:night).and_return(true)
          post :create, params: params

          expect(currency_withdrawal.amount).to eq amount + 110 #110
        end
      end
    end
  end
end
