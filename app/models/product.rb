class Product < ApplicationRecord
  belongs_to :company
  has_many :coment_products
 
  
  #validates :coment_products,presence: true
	
end
