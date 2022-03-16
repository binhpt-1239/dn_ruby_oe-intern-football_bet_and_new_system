class CreateSeasonTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :season_tournaments do |t|
      t.references :season, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true

    end
  end
end
