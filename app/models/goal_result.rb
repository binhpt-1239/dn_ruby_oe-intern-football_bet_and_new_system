class GoalResult < ApplicationRecord
  belongs_to :player
  belongs_to :soccer_match
  belongs_to :team

  scope :newest, ->{order created_at: :desc}

  scope :score, (lambda do |team_id, soccer_match_id|
    where(soccer_match_id: soccer_match_id, team_id: team_id)
  end)

  scope :load_time_goal, (lambda do |soccer_match_id|
    select(:time_goal)
    .where(soccer_match_id: soccer_match_id)
  end)

  delegate :name, to: :player, prefix: :player, allow_nil: true
end
