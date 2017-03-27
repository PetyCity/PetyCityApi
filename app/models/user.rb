class User < ApplicationRecord
  
  #Asociasiones
  has_one :cart, dependent: :destroy
  has_one :company, dependent: :destroy   
  has_many :publications, dependent: :destroy
  has_many :comment_Publications, dependent: :destroy  
  has_many :comment_Products, dependent: :destroy
  has_many :products, through: :company
  has_many :transactions, through: :cart
  
  #VALIDACIONES
  
  validates :name, format: { with: /[a-zA-Z]+(\s*[a-zA-Z]*)*[a-zA-Z]/,message: "only allows letters"
     }, length: { minimum: 5 }, presence: true, on: :update
  validates :cedula, numericality: { only_integer: true ,
              message: "only allows numbers " }, length: { minimum: 5 
             }, uniqueness: { case_sensitive: false }, presence: true, on: :update
  enum rol: [ :admin, :company, :customer ]
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_token_authenticatable
  
  #Queries
  default_scope {order("users.name ASC")}
  #Para el ADMIN:
  def self.users_by_rol(type)
    where(users: {
        rol: type
      })
  end
  def self.users_by_rol_and_id(type,user)
    where(users: {
        rol: type,
        id: user
      })
  end
  def self.users_By_companies()
    joins(:company )
  end

end

