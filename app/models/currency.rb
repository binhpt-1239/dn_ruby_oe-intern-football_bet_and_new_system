class Currency < ApplicationRecord
  belongs_to :user
  belongs_to :currency_type
end
