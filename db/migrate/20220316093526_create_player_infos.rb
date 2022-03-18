class CreatePlayerInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :player_infos do |t|
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :season_tournament, null: false, foreign_key: true

    end
  end
end
