class Admin::PaymentsController < Admin::BaseController
  include EventsHelper
  before_action :load_user_bet, :check_result_bet, only: :create
  before_action :load_bet, only: :create_all

  def create
    payment_user_bet @user_bet
    flag_user_bet @name_success, @name_fails
    redirect_back(fallback_location: admin_root_path)
  end

  def create_all
    user_bets = @bet.user_bets
    user_bets.each do |user_bet|
      next if user_bet.result_bet

      payment_user_bet user_bet
    end
    flag_user_bet @name_success, @name_fails
    redirect_back(fallback_location: admin_root_path)
  end

  private

  def load_user_bet
    @user_bet = UserBet.find_by id: params[:user_bet_id]
    return if @user_bet

    flash[:warning] = t ".not_fond_user_bet"
    redirect_back(fallback_location: admin_root_path)
  end

  def check_result_bet
    return unless @user_bet.result_bet

    flash[:warning] = t ".user_bet_handled"
    redirect_back(fallback_location: admin_root_path)
  end

  def load_bet
    @bet = Bet.find_by id: params[:bet_id]
    return if @bet

    flash[:warning] = t ".not_fond_bet"
    redirect_to admin_root_path
  end

  def payment_user_bet user_bet
    user = user_bet.user
    user_bet.result_bet = true
    user.currencies.new(amount: load_money_win(user_bet).to_i,
                      currency_type_id: :win)
    begin
      ActiveRecord::Base.transaction do
        user_bet.save!
        user.save!
      end
    rescue StandardError
      @name_fails = "#{@name_fails}, " + user.name.to_s
    else
      @name_success = "#{@name_success}, " + user.name.to_s
    end
  end

  def flag_user_bet name_success, name_fails
    flash[:warning] = name_fails + t(".payment_fails") if name_fails
    flash[:success] = name_success + t(".payment_success") if name_success
  end
end
