class User < ApplicationRecord
  
  #Asociasiones
  has_one :cart, dependent: :destroy
  has_one :company, dependent: :destroy   
  has_many :publications, dependent: :destroy
  has_many :comment_Publications, dependent: :destroy  
  has_many :comment_Products, dependent: :destroy
  has_many :products, through: :company
  has_many :transactions, through: :cart
  has_many :sales, through: :cart
  #VALIDACIONES
  
  validates :name_user, format: { with: /[a-zA-Z]+(\s*[a-zA-Z]*)*[a-zA-Z]/,message: "only allows letters"
     }, length: { minimum: 5 }, presence: true, on: :update
  
  validates :cedula, numericality: { only_integer: true ,
              message: "only allows numbers " }, length: { minimum: 5 
             }, uniqueness: { case_sensitive: false }, presence: true, on: :update
 
  enum rol: [ :admin, :company, :customer, :company_customer ]
  
     devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_token_authenticatable
  
  #Queries
    
  default_scope {order("users.name_user ASC")}
  
 
  
  #Para ver todos los usuarios 
  def self.only_users()
    select("users.*") 
  end
  def self.user_by_id_admin(id)
    includes(:comment_Products,:comment_Publications,:publications,
    company: :products,cart: :transactions)    
     .find_by_id(id)
  end
  #Para company  
  def self.user_company_by_id(user)
    includes( company: :products)    
     .find_by_id(id)
  end
   #Para  costummer
  def self.user_custommer_by_id(user)
    includes(:comment_Products,:comment_Publications,:publications,
    cart: :transactions)    
     .find_by_id(id)
  end
 #Para company  ver usuarios compañia
  def self.company_by_user()
    includes(:company ).pluck(:name_user,:cedula,:name_comp,:nit,:permission)
  end
   #Para company  ver informacion de la compañia, usuario productos y  la compañia 
  def self.company_prodruct_by_user()
    includes(company: :products)
    .pluck(:name_user,:cedula,:name_comp,:nit,:permission,:name_product,:status)  
      #.group("users.id")
      #.group("companies.id")
      #.group("products.id")
      #.pluck(:name_user,:cedula,:name_comp,:nit,:permission,:name,:status)    
  end
  #PRODUCTOS Comprados  
  #def self.Product_by_user()
   # joins(cart: :sales).select("users.name","sales.*")
  #end
   #PRODUCTOS EN EL CARRITO 
  def self.cart_by_user()
    joins(cart: :transactions).select("users.name_user","transactions.*")
  end
 #PUBLICACIONES
 def self.users_by_publications()
    joins(:publications).select("users.*","publications.*")
 end
 
#BIen
 #Para ver todos los usuarios segun un rol especifico
  def self.users_by_rol(type)
    where(users: {
        rol: type
      })
  end  

end

