class Bet < ApplicationRecord
  belongs_to :match

  has_many :users, through: :user_bets
end
