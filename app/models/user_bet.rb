class UserBet < ApplicationRecord
  belongs_to :user
  belongs_to :bet

  has_many :teams, dependent: :nullify

  scope :newest, ->{order created_at: :desc}

  delegate :content, to: :bet, prefix: :bet, allow_nil: true

  validates :amount, presence: true,
          numericality: {greater_than_or_equal_to: 0, only_integer: true}
end
