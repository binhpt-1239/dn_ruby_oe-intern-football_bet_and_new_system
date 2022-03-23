class PlayerInfo < ApplicationRecord
  belongs_to :player
  belongs_to :team_tournament
end
