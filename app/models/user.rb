class User < ApplicationRecord
  
  has_one :cart, dependent: :destroy
  has_one :company, dependent: :destroy   
  has_many :publications, dependent: :destroy
  has_many :comment_Publications, dependent: :destroy  
  has_many :comment_Products, dependent: :destroy
  # VALIDACIONES DE ATRIBUTOS
  validates :email, confirmation: true
  validates :email_confirmation, presence: true
  #validates :encrypted_password, confirmation: true
  #validates :encrypted_password_confirmation, presence: true
  
  #validates :name, format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" } , length: { minimum: 5 }
  validates :name, format: { with: /[a-zA-Z]+(\s*[a-zA-Z]*)*[a-zA-Z]/,message: "only allows letters"
     }, length: { minimum: 5 }, presence: true, on: :update
  validates :cedula, numericality: { only_integer: true ,
              message: "only allows numbers " }, length: { minimum: 5 
             }, uniqueness: { case_sensitive: false }, presence: true, on: :update

 #allow_blank: true
  
  acts_as_token_authenticatable
  enum rol: [ :admin, :company, :customer ]
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

end

