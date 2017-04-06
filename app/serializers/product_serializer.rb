class ProductSerializer < ActiveModel::Serializer
    attributes :id, :name_product, :description, :status , :value, :amount, :company_id, :updated_at

end
