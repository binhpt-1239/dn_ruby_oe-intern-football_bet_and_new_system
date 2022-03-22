class UserBet < ApplicationRecord
  belongs_to :user
  belongs_to :bet

  has_many :teams, dependent: :nullify

  validates :bet_amount, presence: true,
          numericality: {greater_than_or_equal_to: 0, only_integer: true}
end
