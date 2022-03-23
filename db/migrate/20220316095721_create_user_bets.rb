class CreateUserBets < ActiveRecord::Migration[6.0]
  def change
    create_table :user_bets do |t|
      t.references :user, null: false, foreign_key: true
      t.float :bet_amount
      t.references :bet, null: false, foreign_key: true
      t.boolean :result

      t.timestamps
    end
  end
end
