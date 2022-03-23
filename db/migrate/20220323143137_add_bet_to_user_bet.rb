class AddBetToUserBet < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_bets, :bet, foreign_key: true
  end
end
