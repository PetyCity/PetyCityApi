class Product < ApplicationRecord
  belongs_to :company
  has_many :coment_products
  has_many :transactions
  has_many :category_products 
  #validates :coment_products,presence: true
	
end
