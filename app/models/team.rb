class Team < ApplicationRecord
  belongs_to :user_bet

  has_many :home_teams, class_name: Match.name,
            foreign_key: :home_id, dependent: :destroy
  has_many :guest_teams, class_name: Match.name,
            foreign_key: :guest_id, dependent: :destroy
  has_many :homes, through: :home_teams, source: :home_team, dependent: :destroy
  has_many :guests, through: :guest_teams, source: :guest_team,
           dependent: :destroy
  has_many :season_tournaments, through: :team_season_tournaments
  has_many :player_infos, dependent: :destroy
end
