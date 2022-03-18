class SeasonTournament < ApplicationRecord
  belongs_to :season
  belongs_to :tournament

  has_many :soccer_matches, dependent: :destroy
  has_many :teams, through: :team_season_tournaments
end
