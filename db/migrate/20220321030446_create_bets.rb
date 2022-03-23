class CreateBets < ActiveRecord::Migration[6.0]
  def change
    create_table :bets do |t|
      t.references :soccer_match, null: false, foreign_key: true
      t.float :rate
      t.integer :bet_type
      t.string :content

      t.timestamps
    end
  end
end
