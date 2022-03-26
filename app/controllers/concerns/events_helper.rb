module EventsHelper
  def load_money_win user_bet
    user_bet.amount * (user_bet.bet_rate + 1)
  end
end
