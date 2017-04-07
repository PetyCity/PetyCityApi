class CategoryProduct < ApplicationRecord
  belongs_to :product
  belongs_to :category
  validates :product , presence: true
  validates :category , presence: true


  #ver categorias en especifico no esta sirviendo

  def self.products_by_category(cat, page = 1, per_page = 10)
     includes(:product)
     .where(category_products: {
        category_id: cat
      })
      .paginate(:page => page,:per_page => per_page)
  end


  def self.categories_by_product(pro, page = 1, per_page = 10)
     includes(:category, :product)
	   .where(category_products: {
        product_id: pro
      })
      .paginate(:page => page,:per_page => per_page)




end
