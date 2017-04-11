class Sale < ApplicationRecord
  #RELATIONSHIPS
	belongs_to :product
	belongs_to :cart
	
	#VALIDATES
	validates :amount, presence: true, numericality: true
	validates :product, presence: true
	validates :cart, presence: true

	#SCOPES
	default_scope {order(amount: :asc)}
	scope :order_by_amount_desc, -> {order(amount: :desc)}
	scope :order_by_id_asc, -> {order(id: :asc)}
  	scope :order_by_id_desc, -> {order(id: :desc)}

	#QUERIES
	def self.load_sales(page = 1, per_page = 10)
	  self.all.paginate(:page => page,:per_page => per_page)
	end

	def self.sales_by_id(id)
		includes(:product,:cart).
	  find_by_id(id)
	end

	def self.sales_by_ids(ids, page = 1, per_page = 10)
	load_sales(page, per_page)
	  .where({id: ids })
	end

	def self.sales_by_not_ids(ids, page = 1, per_page = 10)
		load_sales(page, per_page)
	  		.where.not({id: ids})
	end

	def self.sales_by_products(products_id, page = 1, per_page = 10)
	  where({product_id: products_id})
		.paginate(:page => page,:per_page => per_page)
	end

	def self.sales_by_not_products(products_id, page = 1, per_page = 10)
	  where.not({product_id: products_id})
		.paginate(:page => page,:per_page => per_page)
	end

	def self.sales_by_carts(carts_id, page = 1, per_page = 10)
	  where({cart_id: carts_id})
		.paginate(:page => page,:per_page => per_page)
	end

	def self.sales_by_not_carts(carts_id, page = 1, per_page = 10)
	  where.not({cart_id: carts_id})
		.paginate(:page => page,:per_page => per_page)
	end

	def self.transactions_by_amounts(amount, page = 1, per_page = 10)
	    where("amount = ?", amount)
			.paginate(:page => page,:per_page => per_page)
	end

	def self.transactions_by_amounts_greater(amount, page = 1, per_page = 10)
	    where("amount >= ?", amount)
			.paginate(:page => page,:per_page => per_page)
	end
	def self.transactions_by_amounts_less(amount, page = 1, per_page = 10)
	    where("amount <= ?", amount)
			.paginate(:page => page,:per_page => per_page)
	end
end
