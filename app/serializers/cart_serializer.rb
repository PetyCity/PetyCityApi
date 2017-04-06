class CartSerializer < ActiveModel::Serializer
   
   attributes :id, :user_id, :total_price, :updated_at
   has_many :transactions
   has_many :sales
   has_many :products, through: :transactions

  
 
end
