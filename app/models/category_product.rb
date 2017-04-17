class CategoryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :category
  validates :product , presence: true
  validates :category , presence: true


  #ver categorias en especifico no esta sirviendo

  

  def self.categories_by_product(pro, page = 1, per_page = 10)
     includes(:category)
	   where(category_products: {
        product_id: pro
      }).pluck(:category_id)


  end


end
