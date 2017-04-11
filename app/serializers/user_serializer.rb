class UserSerializer < ActiveModel::Serializer
  attributes :id,:email, :cedula,:name_user,:block,:sendEmail,:rol
   has_one :cart
  has_one :company, dependent: :destroy
  has_many :publications, dependent: :destroy
  has_many :comment_Publications, dependent: :destroy
  has_many :comment_Products, dependent: :destroy
  has_many :c_products, through: :company,source: :products
  has_many :transactions, through: :cart
   has_many :sales, through: :cart
  has_many :s_products , through: :sales, source: :product
  has_many :t_products , through: :transactions, source: :product
  has_many :co_sales, through: :c_products, source: :sales

end
