class CreateBets < ActiveRecord::Migration[6.0]
  def change
    create_table :bets do |t|
      t.references :match, null: false, foreign_key: true
      t.float :rate
      t.string :type

      t.timestamps
    end
  end
end
