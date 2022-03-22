class Bet < ApplicationRecord
  belongs_to :soccer_match, foreign_key: :match_id

  has_many :user_bets, dependent: :destroy
  has_many :users, through: :user_bets

  enum bet_type: {win: 1, draw: 2, lose: 3, h0g0: 4, h0g1: 5, h1g0: 6, h1g1: 7}
end
