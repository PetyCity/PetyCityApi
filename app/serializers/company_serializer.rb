class CompanySerializer < ActiveModel::Serializer
    attributes :id, :nit, :name_comp, :address, :city, :phone, :permission, :user_id,
    :updated_at,:active,:image_company
    has_many :products, dependent: :destroy  
	 belongs_to :user
  	has_many :transactions, through: :products
  	has_many :sales, through: :products
  	has_many :category_products , through: :products, dependent: :destroy  
  

end
