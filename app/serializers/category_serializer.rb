class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name_category, :details, :updated_at

  has_many :products, through: :category_products
  has_many :category_products

  

end
