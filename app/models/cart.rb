class Cart < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :total_price, presence: true,  numericality: true
end
