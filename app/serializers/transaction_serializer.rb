class TransactionSerializer < ActiveModel::Serializer
    attributes :id, :product_id, :cart_id, :amount, :updated_at

end
