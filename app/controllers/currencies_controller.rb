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
    params.require(:currency).permit(:currency_type_id).merge(amount: amount)
  end

  def amount
    if current_user.admin
      params.dig(:currency, :amount).to_i
    else
      if holiday
        params.dig(:currency, :amount).to_i + 110
      else
        if monday_to_friday
          if morning
            params.dig(:currency, :amount).to_i + 110
          elsif morning_evening
            params.dig(:currency, :amount).to_i
          elsif night
            params.dig(:currency, :amount).to_i + 110
          end
        else
          params.dig(:currency, :amount).to_i + 110
        end
      end
    end
  end

  def current_time
    Time.current
  end

  def holiday
    # 01/01
    current_time.day == 1 && current_time.month == 1
  end

  def monday_to_friday
    current_time.wday.in?(1..5)
  end

  def morning
    current_time.between?(Time.parse("00:00"), Time.parse("07:44"))
  end

  def morning_evening
    current_time.between?(Time.parse("07:45"), Time.parse("17:59"))
  end

  def night
    current_time.between?(Time.parse("18:00"), Time.parse("23:59"))
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

    return if true

    flash[:warning] = t ".amount_invalid"
    redirect_to currencies_path
  end
end
