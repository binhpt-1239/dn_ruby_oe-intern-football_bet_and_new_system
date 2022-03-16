class CreateGoalResults < ActiveRecord::Migration[6.0]
  def change
    create_table :goal_results do |t|
      t.references :player, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.time :goal_time

      t.timestamps
    end
  end
end
