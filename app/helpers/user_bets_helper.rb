module UserBetsHelper
  include UsersHelper
  def money_bet_valid? user, money_bet
    sum_amount(user) > money_bet.to_i
  end

  def check_all_result_bet bet
    bet.user_bets.each do |user_bet|
      return false unless user_bet.result_bet
    end
    true
  end
end
