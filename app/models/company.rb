class Company < ApplicationRecord
  after_initialize :set_defaults
  
  has_many :products, dependent: :destroy  
  belongs_to :user
  has_many :transactions, through: :products
  #validates :name, format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" } , length: { minimum: 5 }
  validates :name, format: { with: /[a-zA-Z]+(\s*[a-zA-Z]*)*[a-zA-Z]/,message: "only allows letters"
     }, length: { minimum: 5 }, presence: true, on: :update
   
   validates :address, length: { minimum: 5 }, presence: true, on: :update, uniqueness: { case_sensitive: false }
   alidates :city, format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" } , length: { minimum: 3 }, presence: true, on: :update
  
   validates :phone, numericality: { only_integer: true ,
          message: "only allows numbers " }, length: { minimum: 7 
     }   , uniqueness: { case_sensitive: false }, on: :update 
  validates :nit, numericality: { only_integer: true ,
          message: "only allows numbers " }, length: { is: 10
     }, uniqueness: { case_sensitive: false }, presence: true, on: :update


  def set_defaults
    self.permission = false if self.new_record?
  end
  
end