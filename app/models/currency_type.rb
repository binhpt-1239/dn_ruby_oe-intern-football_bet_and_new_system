class CurrencyType < ApplicationRecord
  has_many :currencies, dependent: :nullify
end
