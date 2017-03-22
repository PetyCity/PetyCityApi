class Sale < ApplicationRecord
  belongs_to :transaction
  belongs_to :product
  belongs_to :cart

  validates :amount, presence: true, numericality: true
end
