class ChangeDataTypeForTimeGoal < ActiveRecord::Migration[6.0]
  def change
    change_column :goal_results, :time_goal, :integer
  end
end
