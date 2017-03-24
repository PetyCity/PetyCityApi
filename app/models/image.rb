class Image < ApplicationRecord
  belongs_to :product

  validates :name, presence: true, length: { in: 3..20 }, uniqueness: true
end
