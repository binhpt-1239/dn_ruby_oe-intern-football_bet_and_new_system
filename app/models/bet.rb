class Bet < ApplicationRecord
  belongs_to :soccer_match

  has_many :users, through: :user_bets
end
