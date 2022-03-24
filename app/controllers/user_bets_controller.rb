class UserBetsController < ApplicationController
  include UserBetsHelper
  before_action :logged_in_user, only: %i(new create index)
  before_action :load_bet, only: %i(new create)
  before_action :check_amount_bet, only: :create

  def new
    @user_bet = current_user.user_bets.new
  end

  def create
    money = params[:user_bet][:amount]
    current_user.currencies.new amount: money,
                                    currency_type_id: :lose
    current_user.user_bets.new user_bet_params
    begin
      User.transaction do
        current_user.save!
      end
    rescue StandardError
      flash[:warning] = t ".fails"
    else
      flash[:success] = t ".success"
    end
    redirect_to root_path
  end

  def index
    bets = current_user.user_bets
    @pagy, @user_bets = pagy bets.newest, items: Settings.digits.digit_6
  end

  private

  def user_bet_params
    params.require(:user_bet).permit(:amount, :bet_id)
  end

  def load_bet
    @bet = Bet.find_by(id: params[:id])
    return if @bet

    flash[:warning] = t ".not_found_bet"
    redirect_to root_path
  end

  def check_amount_bet
    flag = money_bet_valid? current_user, params[:user_bet][:amount]
    return if flag

    flash[:warning] = t ".amount_invalid"
    redirect_to new_user_bet_path
  end
end
