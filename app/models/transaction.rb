class Transaction < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :amount, presence: true, numericality: true
end
