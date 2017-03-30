class Product < ApplicationRecord
  belongs_to :company
  has_many :comment_products
  has_many :transactions
  has_many :category_products 
  has_many :categories, through: :category_products
  has_many :users, through: :comment_products
  validates :name_product, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 10}

  #validates :coment_products,presence: true
  #scope :ultimos, { order("created_at DESC").limit(2) }
  #probando products?

  #Scopes
  default_scope {order("products.name ASC")}


  #para administrador observar los productos que ya estan publicados
  def self.published()
  	Product.where(status:"true")
  end

  #ver producto con id especifico
  def self.products_by_ids(ids)
     where(products:{
        id: ids
      })
  end

  #ver productos por compañia
  def self.products_by_company(comp)
      where(products:{
        id: comp
      })
  end


  #ver productos y su categoria

  def self.products_categories(id)
      includes( :category_products)
      .find_by_id(id)

  end 

  def self.products_transactions(id)
      includes( :transactions)
      .find_by_id(id)

  end 
  

   def self.products_transactions(id)
      includes( :sales)
      .find_by_id(id)

     end 



  #ver todos los productos

  def self.all_products()
    select("products.*") 
  end

   
   ##???
   #producto con su comentario especifico
   
   def self.product_by_id(id)

      includes(comment_product: :users)
      .find_by_id(id)

   end 

   #....

   def self.products_by_category(id)
      includes(:category_products)
      .find_by_id(id)
   end


   def self.cheaper_than(price) 
      where("products.value < ?", price)
   end
  

	
end
