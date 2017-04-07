class Product < ApplicationRecord
  belongs_to :company
  has_many :comment_products
  has_many :transactions
  has_many :sales
  has_many :category_products
  has_many :categories, through: :category_products
  has_many :users, through: :comment_products
  has_many :images
  validates :name_product, presence: true
  validates :description, presence: true, length: { minimum: 10}

  #validates :coment_products,presence: true

  #probando products?

  #Scopes

 

 # default_scope {order("products.name_product ASC")}
  
  scope :ultimos, ->{ order("created_at DESC").limit(4) }
  
  #scope :random, ->{ order('random()') }
 
 def self.rand(page = 1, per_page = 10)
     includes( :images).
    order('random()')
  end

  #ver todos los productos

  def self.all_products(page = 1, per_page = 10)
    select("products.*").paginate(:page => page,:per_page => per_page)
  end
  #ver productos por id
  def self.products_by_id(id, page = 1, per_page = 10)
      where(products:{
        id: id
      })
      .paginate(:page => page,:per_page => per_page)
  end

 
  #ver productos por compañia
  def self.products_by_company(comp, page = 1, per_page = 10)
      where(products:{
        company_id: comp
      })
      .paginate(:page => page,:per_page => per_page)
  end
  #para administrador observar los productos que ya estan publicados
  def self.published(page = 1, per_page = 10)
  	Product.where(status:"true").paginate(:page => page,:per_page => per_page)
  end


  def self.products_transactions(id, page = 1, per_page = 10)
      includes( :transactions)
      .find_by_id(id)
      .paginate(:page => page,:per_page => per_page)
  end
  
  def self.image_by_product(id, page = 1, per_page = 5)
      includes( :images)
      .find_by_id(id)
  end


  def self.products_sales(id, page = 1, per_page = 10)
      includes( :sales)
      .find_by_id(id)
      .paginate(:page => page,:per_page => per_page)
     end

 
 

 # def self.products_most_sales

      #includes( :sales)
      #.group("products.id")
     # .sum("amount").sort("created_at DESC").limit(4) 
    #end 



   #producto con su comentario especifico

   def self.comment_product_by_id(id, page = 1, per_page = 10)
      includes(comment_products: :user)
      .find_by_id(id)
      .paginate(:page => page,:per_page => per_page)
   end

   def self.cheaper_than(price, page = 1, per_page = 10)
      where("products.value <= ?", price)
      .paginate(:page => page,:per_page => per_page)
   end


   def self.major_than(price, page = 1, per_page = 10)
      where("products.value >= ?", price)
      .paginate(:page => page,:per_page => per_page)
   end


end
