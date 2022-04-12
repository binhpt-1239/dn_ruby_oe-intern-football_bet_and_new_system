require "rails_helper"
include SessionsHelper

RSpec.describe CurrenciesController, type: :controller do
  let!(:user){FactoryBot.create :user}
  describe "GET index" do
    context "success when logged in" do
      before do
        log_in user
        get :index
      end

      it "set currencies" do
        currencies = user.currencies.search_by_type(nil)
        expect(assigns(:currencies)).to eq currencies
      end
      it_behaves_like "render action template", "index"
    end

    it_behaves_like "when not logged in", "index"
  end

  describe "GET new" do
    context "success when logged in" do
      before do
        log_in user
        get :new
      end

      it "set currencies user" do
        expect(assigns(:currency)).to be_a_new(Currency)
      end
      it_behaves_like "render action template", "new"
    end

    it_behaves_like "when not logged in", "new"
  end

  describe "POST create" do
    let(:valid_params){{currency: {amount: 1000, currency_type_id: "payment"}}}
    let(:type_invalid_params){{currency: {amount: 1000, currency_type_id: "invalid"}}}
    let(:amount_invalid_params){{currency: {amount: 1000, currency_type_id: "withdrawal"}}}
    context "success with valid params" do
      let!(:count){Currency.count}
      before do
        log_in user
        post :create, params: valid_params
      end

      it "creates a new Currency" do
        expect(Currency.count).to eq(count+1)
      end
      it_behaves_like "flash success message", "currencies.create.success"
      it_behaves_like "redirect to path", "currencies_path"
    end

    it_behaves_like "when not logged in", "create"

    context "fails when save fails " do
      before do
        log_in user
        allow_any_instance_of(Currency).to receive(:save).and_return(false)
        post :create, params: valid_params
      end

      it_behaves_like "flash warning message", "currencies.create.fails"
      it_behaves_like "redirect to path", "currencies_path"
    end

    context "fails when type invalid" do
      before do
        log_in user
        post :create, params: type_invalid_params
      end

      it_behaves_like "flash warning message", "currencies.create.fails"
      it_behaves_like "redirect to path", "currencies_path"
    end

    context "fails when withdrawal invalid amount" do
      before do
        log_in user
        post :create, params: amount_invalid_params
      end

      it_behaves_like "flash warning message", "currencies.amount_invalid"
      it_behaves_like "redirect to path", "currencies_path"
    end
  end
end
