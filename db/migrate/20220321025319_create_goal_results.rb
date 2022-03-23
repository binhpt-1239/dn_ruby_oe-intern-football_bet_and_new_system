class CreateGoalResults < ActiveRecord::Migration[6.0]
  def change
    create_table :goal_results do |t|
      t.references :player, foreign_key: true
      t.datetime :time_goal
      t.references :soccer_match, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
