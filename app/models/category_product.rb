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


def self.user_by_id_admin(id)
    includes(:comment_Products,:comment_Publications,:publications,
    company: :products,cart: :transactions)    
     .find_by_id(id)
  end
  
end
