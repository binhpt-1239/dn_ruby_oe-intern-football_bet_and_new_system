class Match < ApplicationRecord
  belongs_to :season_tournament
  belongs_to :home_team, class_name: Team.name
  belongs_to :guest_team, class_name: Team.name

  has_many :bets, dependent: :destroy
  has_many :goal_results, dependent: :destroy
end
