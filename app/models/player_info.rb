class PlayerInfo < ApplicationRecord
  belongs_to :player
  belongs_to :team
  belongs_to :season_tournament
end
