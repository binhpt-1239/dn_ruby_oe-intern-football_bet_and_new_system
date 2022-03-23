class Tournament < ApplicationRecord
  has_many :teams, through: :team_tournaments
end
