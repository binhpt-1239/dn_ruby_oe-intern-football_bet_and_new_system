class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.references :season_tournament, null: false, foreign_key: true
      t.datetime :date_time
      t.integer :home_id
      t.integer :guest_id

    end
  end
end
