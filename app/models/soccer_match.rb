class SoccerMatch < ApplicationRecord
  belongs_to :tournament
  belongs_to :home_team, class_name: Team.name, foreign_key: :home_id
  belongs_to :guest_team, class_name: Team.name, foreign_key: :guest_id

  has_many :bets, dependent: :destroy
  has_many :goal_results, dependent: :destroy
  has_many :user_bets, through: :bets

  delegate :name, to: :home_team, prefix: :home, allow_nil: true
  delegate :name, to: :guest_team, prefix: :guest, allow_nil: true
  delegate :name, to: :tournament, prefix: :tournament, allow_nil: true

  scope :newest, ->{order(time: :asc)}
end
