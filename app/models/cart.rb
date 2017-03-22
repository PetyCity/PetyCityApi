class Cart < ApplicationRecord
  belongs_to :user

  validates :total_price, presence: true,  numericality: true
end
