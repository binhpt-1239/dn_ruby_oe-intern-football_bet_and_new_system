class CreatePlayerInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :player_infos do |t|
      t.references :player, foreign_key: true
      t.references :team_tournament, foreign_key: true

      t.timestamps
    end
  end
end
