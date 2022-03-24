class RemoveSoccerMatchsFromUserBets < ActiveRecord::Migration[6.0]
  def change
    remove_reference :user_bets, :soccer_match, foreign_key: true
  end
end
