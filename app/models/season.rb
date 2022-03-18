class Season < ApplicationRecord
  has_many :tournaments, through: :season_tournaments, dependent: :destroy
end
