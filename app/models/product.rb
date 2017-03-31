class Product < ApplicationRecord
  belongs_to :company
  has_many :comment_products
  has_many :transactions
  has_many :category_products 
  has_many :categories, through: :category_products
  has_many :users, through: :comment_products
  validates :name_product, presence: true
  validates :description, presence: true, length: { minimum: 10}

  #validates :coment_products,presence: true
  
  #probando products?

  #Scopes
  default_scope {order("products.name_product ASC")}
  
  scope :ultimos, ->{ order("created_at DESC").limit(4) }



  #ver todos los productos

  def self.all_products()
    select("products.*") 
  end


  #ver productos por id
  def self.products_by_id(id)
      where(products:{
        id: id
      })
  end
  
  #ver productos por compañia
  def self.products_by_company(comp)
      where(products:{
        company_id: comp
      })
  end



  #para administrador observar los productos que ya estan publicados
  def self.published()
  	Product.where(status:"true")
  end

 





  def self.products_transactions(id)
      includes( :transactions)
      .find_by_id(id)

  end 
  

  def self.products_sales(id)
      includes( :sales)
      .find_by_id(id)
     end 

   
   #producto con su comentario especifico
   
   def self.comment_product_by_id(id)
      includes(comment_products: :user)
      .find_by_id(id)
   end 

   def self.cheaper_than(price) 
      where("products.value <= ?", price)
   end
   def self.major_than(price) 
      where("products.value >= ?", price)
   end
  

	
end
