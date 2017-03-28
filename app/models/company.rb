class Company < ApplicationRecord
  after_initialize :set_defaults
  
  has_many :products, dependent: :destroy  
  belongs_to :user
  has_many :transactions, through: :products
  #validates :name, format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" } , length: { minimum: 5 }
  validates :name_comp, format: { with: /[a-zA-Z]+(\s*[a-zA-Z]*)*[a-zA-Z]/,message: "only allows letters"
     }, length: { minimum: 5 }, uniqueness: { case_sensitive: false }, presence: true
   
   validates :address, length: { minimum: 5 }, presence: true, uniqueness: { case_sensitive: false }
   validates :city, format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" } , length: { minimum: 3 }, presence: true
   validates :phone, numericality: { only_integer: true ,
          message: "only allows numbers " }, length: { minimum: 7 
     }   , uniqueness: { case_sensitive: false }
  validates :nit, numericality: { only_integer: true ,
          message: "only allows numbers " }, length: { is: 10
     }, uniqueness: { case_sensitive: false }, presence: true

  validates :user , uniqueness: { case_sensitive: false }, presence: true
  
  
  def set_defaults
    self.permission = false if self.new_record?
  end
  #Para el ADMIN: 
 # def self.userID_by_publications(user)
    #joins(:publications).select("users.*","publications.*")
    #.where(users: {
   #     id: user
  #    })
 #end
   #Para company  ver informacion de la compañia, usuario productos y datos de la compañia 
  def self.company_by_userID(id)
    joins(company: :products)
    .find_by_id(id)
    
  end
  
  
end