class CategoryProductSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :category_id, :updated_at
end
