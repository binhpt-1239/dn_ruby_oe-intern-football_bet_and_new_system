module EventsHelper
  def load_money_win user_bet
    user_bet.amount * (user_bet.bet_rate + Settings.digits.digit_1)
  end

  def total_win_bet winners
    winners.reduce(Settings.digits.digit_0){|a, e| a + load_money_win(e)}
  end

  def check_bet_empty? match
    match.bets.empty?
  end
end
