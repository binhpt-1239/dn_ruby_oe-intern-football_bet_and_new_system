class TeamSeasonTournament < ApplicationRecord
  belongs_to :team
  belongs_to :season_tournament
end
