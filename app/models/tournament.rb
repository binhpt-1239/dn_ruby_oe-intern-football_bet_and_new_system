class Tournament < ApplicationRecord
  has_many :season_tournaments, dependent: :destroy
  has_many :seasons, through: :season_tournaments
end
