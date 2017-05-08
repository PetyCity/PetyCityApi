class Product < ApplicationRecord
  acts_as_votable
  belongs_to :company


  has_many :comment_products, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :sales

  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products
  has_many :users, through: :comment_products

  has_many :images, dependent: :destroy
  
  
  has_many :votes , foreign_key: :votable_id

  
  
  validates :name_product, presence: true
  validates :description, presence: true, length: { minimum: 10}
  validates :description, presence: true, length: { minimum: 2}

  #validates :coment_products,presence: true

  #probando products?

  #Scopes


 # default_scope {order("products.name_product ASC")}
  
  scope :ultimos, ->{ order("created_at DESC").limit(4) }
 
   
  def self.product_by_votes_pop()
      includes( :votes,:images) 
      .where(votes: {
        votable_type: "Product"
      }) 
      #.group(:votes:votable_id) 
      #.select('products.* ,votes.votable_id ,COUNT(votes.vote_weight) as num_votes')
      
      #.select('votable_id as id,COUNT(vote_weight) as num_votes')    
  end 
 def self.rand(page = 1, per_page = 10)
     includes( :images)
     .where(products: {
        active: true
     })
     .order('random()')
  end
   def self.rand_custummer(pro,page = 1, per_page = 10)
     includes( :images)
     .where(products: {
        active: true
     })
     .where.not(products: {
        id: pro
      })
     .order('random()')
  end

def self.products_images(page = 1, per_page = 10)
     includes( :images)
     .where(products: {
        active: true
     })
     .order('random()')  
end


  #ver todos los productos

  def self.all_products(page = 1, per_page = 10)
    select("products.*")
    .where(products: {
        active: true
     })

  end
  #ver productos por id
  def self.products_by_id(id, page = 1, per_page = 100)
      includes( :images)
      .where(products:{
        id: id
      })      
     .where(products: {
        active: true
     })

  end

 
  #ver productos por compañia
  def self.products_by_company(comp)
      where(products:{
        company_id: comp,
        active: true
      })
      .order('random()')
  end
  #para administrador observar los productos que ya estan publicados
  def self.published(page = 1, per_page = 10)
  	Product.where(status:"true")
  	.where(products: {
        active: true
     })

  end


  def self.products_transactions(id, page = 1, per_page = 10)
      includes( :transactions)
      .find_by_id(id)
  
  end
  
  def self.image_by_product(id, page = 1, per_page = 5)
      includes( :images, :comment_products)
      .find_by_id(id)
  end

   def self.product_by_id_total(id, page = 1, per_page = 5)
      includes( :images, :comment_products,:categories,:company, :sales, :users)
      .find_by_id(id)
  end


  def self.products_sales(id)
      includes( :sales)
      .find_by_id(id)
     end

 
 

 # def self.products_most_sales
  #    includes( :sales)
   #  .group("products.id")
    # .sum("products.amount")
     
    #end 


  def self.products_most_sales
      joins( :sales)
      .includes( :images)
     .group("products.id")
     .order("SUM(sales.amount) DESC")          
    end
    
    def self.products_most_sales_unique(ids)
     joins( :sales)
     .includes( :images)
     .where(products: {
        id: ids,
        active: true
     }) 
     .group("products.id")
     .order("SUM(sales.amount) DESC")          
    end
   #producto con su comentario especifico

   def self.comment_product_by_id(id, page = 1, per_page = 10)
      includes(comment_products: :user)
      .find_by_id(id)
    #  .paginate(:page => page,:per_page => per_page)
   end

   def self.cheaper_than(price, page = 1, per_page = 10)
      where("products.value <= ?", price)
     # .paginate(:page => page,:per_page => per_page)
   end


   def self.major_than(price, page = 1, per_page = 10)
      where("products.value >= ?", price)
      #.paginate(:page => page,:per_page => per_page)
   end

  def self.products_by_categories(cat)
     includes( :categories,:images)
     .where(categories: {
        id: cat
      })
      .where(products: {
        active: true
     })   
     .order('random()')  
      
  end
  
 

  def self.products_by_category(cat,pro)
     includes( :categories,:images)
     .where(categories: {
        id: cat
      })
     .where.not(products: {
        id: pro
      })
      .order('random()')
      .limit(4)
  end


  def self.products_by_name(word)
     includes(:images)
     .where("products.name_product ILIKE ? ",word)
     .where(products: {
        active: true
     })
     .order('random()')  
  end
  def self.products_by_category_name(cat,word)
     includes( :categories,:images)
     .where(categories: {
        id: cat
      })
     .where("products.name_product ILIKE ? ",word)
     .where(products: {
        active: true }) 
  end
  
   #ver productos por compañia
  def self.products_distinc_by_company(comp,pro)
      where(products:{
        company_id: comp,
        active: true
      })
      .where.not(products: {
        id: pro
      })
      .order('random()')
  end


  def self.products_most_comment(ids)
     joins( :comment_products)
     .includes( :images)
     .where(products: {
        id: ids,
        active: true
     }) 
     .group("products.id")
     .order("Count(products.id) DESC")          
  end
    
    
end
