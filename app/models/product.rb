class Product < ApplicationRecord
  belongs_to :company
  has_many :coment_products
 
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, length: { minimum: 10}
  #validates :coment_products,presence: true
	
end
