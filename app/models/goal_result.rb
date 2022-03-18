class GoalResult < ApplicationRecord
  belongs_to :player
  belongs_to :soccer_match
end
