class Cart < ApplicationRecord
  #RELATIONSHIPS
  belongs_to :user
  has_many :transactions

  #VALIDATIONS
  validates :total_price, presence: true,  numericality: true

  #SCOPES
  default_scope {order(total_price: :asc)}
  scope :order_by_total_price_desc, -> {order(total_price: :desc)}
  scope :order_by_id_asc, -> {order(id: :asc)}
  scope :order_by_id_desc, -> {order(id: :desc)}

  #QUERIES
  def self.load_carts(page = 1, per_page = 10)
      paginate(:page => page, :per_page => per_page)
  end

  def self.cart_by_id(id)
      find_by_id(id)
  end

  def self.carts_by_ids(ids, page = 1, per_page = 10)
    load_carts(page,per_page)
      .where({id: ids })
  end

  def self.carts_by_not_ids(ids, page = 1, per_page = 10)
    load_carts(page,per_page)
      .where.not({id: ids})
  end

  def self.carts_by_user_id(users_id, page = 1, per_page = 10)
      where({user_id: users_id}).paginate(:page => page, :per_page => per_page)	
  end
  def self.carts_by_not_user_id(users_id, page = 1, per_page = 10)
      where.not({user_id: users_id}).paginate(:page => page, :per_page => per_page) 
  end

  def self.carts_by_total_prices(total_prices, page = 1, per_page = 10)
      where({total_price: total_prices}).paginate(:page => page, :per_page => per_page)   
  end

  def self.carts_by_not_total_prices(total_prices, page = 1, per_page = 10)
      where.not({total_price: total_prices}).paginate(:page => page, :per_page => per_page) 
  end

  def self.user()
    User.where('id = ?', self.user_id )
  end

  def self.transactions()
    Transaction.where('id = ?', self.id )
  end

end
