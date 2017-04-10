class CategoryProductSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :category_id, :updated_at
  belongs_to :product
  belongs_to :category

end
