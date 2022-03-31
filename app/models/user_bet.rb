class UserBet < ApplicationRecord
  belongs_to :user
  belongs_to :bet

  has_many :teams, dependent: :nullify

  scope :newest, ->{order created_at: :desc}
  scope :load_result_bet, ->(result){where result_bet: result}

  scope :load_by_date, (lambda do |start_month, end_month|
    where(Settings.sql.sql_find_period,
          start_month, end_month)
  end)

  delegate :content, to: :bet, prefix: :bet, allow_nil: true
  delegate :rate, to: :bet, prefix: :bet, allow_nil: true

  validates :amount, presence: true,
          numericality: {greater_than_or_equal_to: 0}

  def self.search start_month, end_month
    if start_month && end_month
      UserBet.load_by_date start_month, end_month
    else
      UserBet.load_by_today
    end
  end
end
