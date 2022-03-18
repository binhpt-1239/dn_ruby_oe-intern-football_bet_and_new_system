class GoalResult < ApplicationRecord
  belongs_to :player
  belongs_to :match
end
