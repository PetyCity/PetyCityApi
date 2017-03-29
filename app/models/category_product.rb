class CategoryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :category


  #ver categorias en especifico no esta sirviendo
 
  def self.category_by_ids(ids)
     where(category_products:{
        id: ids
      })
  end

  def self.product_by_category(cat)
	where(category_products: {
        id:  cat
      })
  end

end
