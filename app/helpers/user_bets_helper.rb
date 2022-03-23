module UserBetsHelper
  include UsersHelper
  def money_bet_valid? user, money_bet
    sum_amount(user) > money_bet.to_i
  end
end
