class UserBet < ApplicationRecord
  belongs_to :user
  belongs_to :bet

  has_many :teams, dependent: :nullify
end
