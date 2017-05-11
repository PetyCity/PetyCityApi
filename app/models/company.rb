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
  validates :name_comp,  length: { in: 3..30 }, uniqueness: { case_sensitive: false }, presence: true
   validates :address,  length: { in: 3..30 }, presence: true, uniqueness: { case_sensitive: false }
   validates :city,  length: { in: 3..30 }, presence: true
   validates :phone, numericality: { only_integer: true ,
          message: "only allows numbers " }, length: { in: 6..20 },
           uniqueness: { case_sensitive: false }
  validates :nit, numericality: { only_integer: true ,
          message: "only allows numbers " }, length: { is: 10
     }, uniqueness: { case_sensitive: false }, presence: true
  validates :user , uniqueness: { case_sensitive: false }, presence: true  
  validates :c_rol, presence: true
  enum c_rol: [ :veterinary ,:wholesaler,:hairdressing , :pethotel, :trainer ]
  
  #Queries

  #default_scope {order("companies.name_comp ASC")}

  def self.companies_by_name(word)
     includes(:user,:products)
     .where("companies.name_comp ILIKE ? ",word)
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
    joins(products:  :sales)
    .group("companies.id")
    .order("COUNT(companies.id) DESC")          
 
  end
  #Productos vendidos id
  def self.product_salesID(id, page = 1, per_page = 10)
    includes(products: :sales )
     .find_by_id(id)
     .paginate(:page => page,:per_page => per_page)
  end

  def self.companies_by_name_category(word,rol)
     includes(:user,:products)
     .where("companies.name_comp ILIKE ? ",word)
     .where(companies: {
        c_rol:rol,
        active: true
     })
  end
  def self.company_by_rol(rol)
    includes(:user,:products)
     where(
        c_rol:rol,
        active: true
     )   
     .order('random()')       
  end
  def self.company_by_rol_permission(rol,perm)
    includes(:user,:products)
     where(
        c_rol:rol,
        permission:perm,
        active: true
     )   
     .order('random()')       
  end
  def self.company_by_name_permission(word,perm)
     includes(:user,:products)
     .where("companies.name_comp ILIKE ? ",word)
     .where(
        permission:  perm,
        active: true
     )   
     .order('random()')       
  end
  def self.company_by_permission(perm)
     includes(:user,:products)
     .where(
        permission:perm,
        active: true
     )   
     .order('random()')       
  end
  
  def self.companies_by_name_category_permission(word,rol,perm)
     includes(:user,:products)
     .where("companies.name_comp ILIKE ? ",word)
     .where(
        c_rol:rol,
        permission:  perm,
        active: true
     )   
     .order('random()')       
  end

end
