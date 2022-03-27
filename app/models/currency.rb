class Currency < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :currency_type

  enum currency_type_id: {payment: 1, withdrawal: 2, win: 3, lose: 4}

  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 0,
                                                    only_integer: true}
  scope :newest, ->{order created_at: :desc}
  scope :search_by_type, ->(type){where currency_type_id: type if type.present?}
end
