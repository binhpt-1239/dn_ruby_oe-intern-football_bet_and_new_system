class TeamTournament < ApplicationRecord
  belongs_to :team
  belongs_to :tournament
  has_many :player_infos, dependent: :destroy
  has_many :players, through: :player_infos
end
