class Cart < ApplicationRecord
 #RELATIONSHIPS
  belongs_to :user
  has_many :transactions
  has_many :sales
  has_many :products, through: :transactions

  #VALIDATIONS
  validates :total_price, presence: true,  numericality: true
  validates :user, presence: true

  #SCOPES
  default_scope {order(total_price: :asc)}
  scope :order_by_total_price_desc, -> {order(total_price: :desc)}
  scope :order_by_id_asc, -> {order(id: :asc)}
  scope :order_by_id_desc, -> {order(id: :desc)}

  #QUERIES
  def self.load_carts(page =1, per_page = 10)
      self.all.paginate(:page => page, :per_page => per_page)
  end

  def self.cart_by_id(id)
      includes(:products, :sales)
      .find_by_id(id)
  end

  def self.carts_by_ids(ids, page = 1, per_page = 10)
    load_carts(page, per_page).where({id: ids })
  end

  def self.carts_by_not_ids(ids, page = 1, per_page = 10)
    load_carts(page,per_page)
      .where.not({id: ids})
  end

  def self.carts_by_user_id(users_id, page = 1, per_page = 10)
      includes(:products, :sales,:transactions)
      .where({user_id: users_id})
      .paginate(:page => page,:per_page => per_page)
  end

  def self.carts_by_total_prices(total_price, page = 1, per_page = 10)
      includes(:products, :sales)
      .where("total_price = ?", total_price)
      .paginate(:page => page,:per_page => per_page)
  end

  def self.carts_by_total_prices_greater (total_price, page = 1, per_page = 10)
      includes(:products, :sales)
      .where("total_price >= ?", total_price)
      .paginate(:page => page,:per_page => per_page)
  end

  def self.carts_by_total_prices_less(total_price, page = 1, per_page = 10)
      includes(:products, :sales)
      .where("total_price <= ?", total_price)
      .paginate(:page => page,:per_page => per_page)
  end

  def self.transactions(cart_id, page = 1, per_page = 10)
    includes(:transactions).find_by_id(cart_id)
    .paginate(:page => page,:per_page => per_page)
  end

  def self.sales(cart_id, page = 1, per_page = 10)
    includes(:sales).
    find_by_id(cart_id)
    .paginate(:page => page,:per_page => per_page)
  end

  def self.products(cart_id, page = 1, per_page = 10)
    includes(:products).
    find_by_id(cart_id)
    .paginate(:page => page,:per_page => per_page)
  end

end
