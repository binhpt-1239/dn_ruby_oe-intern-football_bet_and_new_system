class CurrenciesController < ApplicationController
  include EventsHelper

  before_action :logged_in_user, only: %i(index new create)
  before_action :check_type, :check_amount_bet, only: :create

  def index
    moneys = current_user.currencies.search_by_type(params[:type]).newest
    @pagy, @currencies = pagy moneys, items: Settings.digits.digit_6
  end

  def new
    @currency = current_user.currencies.build
  end

  def create
    currency = current_user.currencies.new currency_params
    if currency.save
      flash[:success] = t ".success"
    else
      flash[:warning] = t ".fails"
    end
    redirect_to currencies_path
  end

  private

  def currency_params
    params.require(:currency).permit(:amount, :currency_type_id)
  end

  def check_type
    flag = Currency.currency_type_ids[params.dig :currency, :currency_type_id]
    action_if_type_current_not_found unless flag
  end

  def action_if_type_current_not_found
    flash[:warning] = t ".fails"
    redirect_to currencies_path
  end

  def check_amount_bet
    return if params[:currency][:currency_type_id] != "withdrawal"

    return if money_bet_valid? current_user, params[:currency][:amount]

    flash[:warning] = t ".amount_invalid"
    redirect_to currencies_path
  end
end
