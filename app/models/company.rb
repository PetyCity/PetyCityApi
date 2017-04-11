class Company < ApplicationRecord
  has_many :products, dependent: :destroy
  belongs_to :user
  has_many :transactions, through: :products
  has_many :sales, through: :products
  has_many :category_products , through: :products, dependent: :destroy




  #has_many :sales, through: :products
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


  #Queries

  default_scope {order("companies.name_comp ASC")}

  #Para ver todos los usuarios
  def self.only_companies(page = 1, per_page = 102)
    select("companies.*").paginate(:page => page,:per_page => per_page)
  end
  #ver productos y su categoria
  def self.company_by_id_adminComp(id, page = 1, per_page = 10)
    includes(products: :transactions,products: :category_products  )
     .find_by_id(id)
     .paginate(:page => page,:per_page => per_page)
  end
  #compañia en especifico
  def self.company_by_id(comp, page = 1, per_page = 10)
    where(companies: {
        id: comp
      })
      .paginate(:page => page,:per_page => per_page)
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
