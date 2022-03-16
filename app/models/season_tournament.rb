class SeasonTournament < ApplicationRecord
  belongs_to :season
  belongs_to :tournament

  has_many :matches, dependent: :destroy
  has_many :teams, through: :team_season_tournaments
end
