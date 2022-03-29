class UserBet < ApplicationRecord
  belongs_to :user
  belongs_to :bet

  has_many :teams, dependent: :nullify

  enum result_bet: {lose: 0, win: 1}

  scope :newest, ->{order created_at: :desc}
  scope :load_result_bet, ->(result){where result_bet: result}

  delegate :content, to: :bet, prefix: :bet, allow_nil: true
  delegate :rate, to: :bet, prefix: :bet, allow_nil: true

  validates :amount, presence: true,
          numericality: {greater_than_or_equal_to: 0}
end
