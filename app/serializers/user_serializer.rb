class UserSerializer < ActiveModel::Serializer

  attributes :id,:email, :document,:name_user,:block,:sendEmail,:rol,:active
   has_one :cart, dependent: :destroy
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
