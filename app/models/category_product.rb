class CategoryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :category
  validates :product , presence: true
  validates :category , presence: true
  
  
  #ver categorias en especifico no esta sirviendo
 
  def self.products_by_category(cat)
     includes(:product)  
     .where(category_products: {
        category_id: cat
      })     
  end

  def self.categories_by_product(pro)
     includes(:category,:product)
	   .where(category_products: {
        product_id: pro
      }) 
  end


  
end
