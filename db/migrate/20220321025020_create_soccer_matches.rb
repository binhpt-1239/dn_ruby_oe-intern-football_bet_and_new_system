class CreateSoccerMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :soccer_matches do |t|
      t.integer :home_id
      t.integer :guest_id
      t.references :tournament, foreign_key: true
      t.datetime :time

    end
  end
end
