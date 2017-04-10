class ProductSerializer < ActiveModel::Serializer
    attributes :id, :name_product, :description, :status , :value, :amount, :company_id
    belongs_to :company
	has_many :comment_products
	has_many :transactions
	has_many :sales
	has_many :category_products 
	has_many :categories, through: :category_products
	has_many :users, through: :comment_products
	has_many :images
	  
end
