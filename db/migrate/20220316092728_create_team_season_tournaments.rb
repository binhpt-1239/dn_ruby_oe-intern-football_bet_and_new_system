class CreateTeamSeasonTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :team_season_tournaments do |t|
      t.references :team, null: false, foreign_key: true
      t.references :season_tournament, null: false, foreign_key: true

    end
  end
end
