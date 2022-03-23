class CreateUserBets < ActiveRecord::Migration[6.0]
  def change
    create_table :user_bets do |t|
      t.references :user, foreign_key: true
      t.float :amount
      t.references :soccer_match, foreign_key: true
      t.references :team, foreign_key: true
      t.boolean :result_bet

      t.timestamps
    end
  end
end
