class RemoveTeamFromUserBets < ActiveRecord::Migration[6.0]
  def change
    remove_reference :user_bets, :team, foreign_key: true
  end
end
