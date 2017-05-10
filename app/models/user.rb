class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  acts_as_voter
  #Asociasiones
  has_one :cart
  has_one :company, dependent: :destroy
  has_many :publications, dependent: :destroy
  has_many :comment_Publications, dependent: :destroy
  has_many :comment_Products, dependent: :destroy
  has_many :c_products, through: :company,source: :products
  has_many :transactions, through: :cart
   has_many :sales, through: :cart
  has_many :s_products , through: :sales, source: :product
  has_many :t_products , through: :transactions, source: :product
  
  has_many :co_sales, through: :c_products, source: :sales


#
def self.prueba(name)
    joins(sales: [{product: :categories}]).select("users.id").
    where(categories: {
        name_category: name
      })
  end

  #VALIDACIONES

  validates :name_user, format: { with: /[a-zA-Z]+(\s*[a-zA-Z]*)*[a-zA-Z]/,message: "only allows letters"
     }, length: { minimum: 5 }, presence: true

  validates :document, numericality: { only_integer: true ,
              message: "only allows numbers " }, length: { minimum: 5
             }, uniqueness: { case_sensitive: false }, presence: true

  enum rol: [ :admin, :company, :customer, :company_customer ]

     devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  #Queries

  #default_scope {order("users.name_user ASC")}

  #Para ver todos los usuarios
  def self.only_users(page = 1, per_page = 100)
    select("users.*")
    .where(users: {
        active: true
     })
    .paginate(:page => page,:per_page => per_page)
  end
  
  
  
  def self.user_by_id_admin(id)
    find_by_id(id)
  end 
  
  #Para company
  def self.user_company_by_id(id)
    includes( :company, c_products: :sales)
     .find_by_id(id)
  end
  
  
   #Para  costummer
  def self.user_custommer_by_id(id)
    includes(:comment_Products,:comment_Publications,:publications,
    cart: :sales)
     .find_by_id(id)
  end
  
   #Para company-costummer
  def self.user_comp_custommer_by_id(id)
    includes(:company,:comment_Products,:comment_Publications,:publications,
    cart: :sales, c_products: :sales)
     .find_by_id(id)
  end 

 #Para company  ver usuarios compañia
  def self.company_by_user_id(id)
    includes(:company )
    .find_by_id(id)
  end


   #Para company  ver informacion de la compañia, usuario productos y  la compañia
  def self.company_prodruct_by_user()
    includes(company: :products)
    .pluck(:name_user,:cedula,:name_comp,:nit,:permission,:name_product,:status)

  end


  #PRODUCTOS Comprados  
  def self.product_sale_by_user()
    includes(sales: :product)
  end

#PRODUCTOS Comprados  pir id user
  def self.product_sale_by_user_byID(id)
    includes(sales: :product)
    .find_by_id(id)
  end


   #PRODUCTOS EN EL CARRITO
  def self.cart_by_user()
     includes(transactions: :product)
  end
  #PRODUCTOS EN EL CARRITO por id
  def self.cart_by_userID(id)
     includes(transactions: :product)
     .find_by_id(id)
  end
 #PUBLICACIONES
 def self.users_by_publications()
    includes(:publications)
 end
 
#
def self.prueba(name)
    joins(sales: [{product: :categories}]).select("users.id").
    where(categories: {
        name_category: name
      })    
  end


  def self.users_by_name(word)     
      where("users.name_user ILIKE ?",word)
  end
  def self.users_by_email(word,user)     
      where("users.email ILIKE ?",word)
      .where.not(  
      id: user
      )
  end
  #Para ver todos los usuarios segun un rol especifico
  def self.users_by_rol(type,user)
    where.not(  
      id: user)
    .where(users: {
        rol: type,
        active: true
      })
  end 
end
