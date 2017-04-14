class UserSerializer < ActiveModel::Serializer
  attributes :id,:email, :document,:name_user,:block,:sendEmail,:rol,:active
   has_one :cart, dependent: :destroy
  has_one :company, dependent: :destroy   
  has_many :publications, dependent: :destroy
  has_many :comment_Publications, dependent: :destroy  
  has_many :comment_Products, dependent: :destroy
  has_many :products, through: :company,source: :product
  has_many :transactions, through: :cart
  has_many :sales, through: :cart
  has_many :products , through: :sales, source: :prodcut
  has_many :products , through: :transactions, source: :product

end
