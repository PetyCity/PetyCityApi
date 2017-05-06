class Company < ApplicationRecord
   mount_uploader :image_company, ImageCompanyUploader
  acts_as_votable
  has_many :products, dependent: :destroy
  belongs_to :user
  has_many :transactions, through: :products
  has_many :sales, through: :products
  has_many :category_products , through: :products, dependent: :destroy
  #has_many :sales, through: :products
  #validates :name, format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" } , length: { minimum: 5 }
  validates :name_comp, length: { minimum: 3 }, uniqueness: { case_sensitive: false }, presence: true
   validates :address, length: { minimum: 5 }, presence: true, uniqueness: { case_sensitive: false }
   validates :city, length: { minimum: 3 }, presence: true
   validates :phone, numericality: { only_integer: true ,
          message: "only allows numbers " }, length: { minimum: 7
     }   , uniqueness: { case_sensitive: false }
  validates :nit, numericality: { only_integer: true ,
          message: "only allows numbers " }, length: { is: 10
     }, uniqueness: { case_sensitive: false }, presence: true
  validates :user , uniqueness: { case_sensitive: false }, presence: true



  #Queries

  default_scope {order("companies.name_comp ASC")}

  def self.companies_by_name(word)
     includes(:user,:products)
     .where("companies.name_comp LIKE ? ",word)
     .where(companies: {
        active: true
     })
  end
  #Para ver todos los usuarios
  def self.only_companies(page = 1, per_page = 102)
    includes(:user,:products)
     .where(companies: {
        active: true
     })
    .paginate(:page => page,:per_page => per_page)
  end
  #ver productos y su categoria
  def self.company_by_id_adminComp(id)
    includes( :sales,:products,:user )
     .find_by_id(id)
  end
   
  
  #compañia en especifico
  def self.company_by_id(comp)
    includes(:products,:user  )
     .find_by_id(comp)
  end
  #Productos vendidos
  def self.product_sales(page = 1, per_page = 10)
    includes(products: :sales ).paginate(:page => page,:per_page => per_page)
  end
  #Productos vendidos id
  def self.product_salesID(id, page = 1, per_page = 10)
    includes(products: :sales )
     .find_by_id(id)
     .paginate(:page => page,:per_page => per_page)
  end



end
