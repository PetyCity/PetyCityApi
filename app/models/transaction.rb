class Transaction < ApplicationRecord
 	#RELATIONSHIPS
    belongs_to :product
    belongs_to :cart

    #VALIDATIONS
	validates :amount, presence: true, numericality: true
	validates :cart, presence: true
	validates :product, presence: true

	#SCOPES
	default_scope {order(amount: :asc)}
	scope :order_by_amount_desc, -> {order(amount: :desc)}
	scope :order_by_id_asc, -> {order(id: :asc)}
  	scope :order_by_id_desc, -> {order(id: :desc)}

	#QUERIES
	def self.load_transactions()
	    self.all
	end

	def self.transaction_by_id(id)
		includes(:product,:cart).
	     find_by_id(id)
  	end

	def self.transactions_by_ids(ids)
		load_transactions()
	  .where({id: ids })
	end

	def self.transactions_by_not_ids(ids)
		load_transactions(page,per_page)
	  	.where.not({id: ids})
	end

	def self.transactions_by_products(products_id)
	  	where({product_id: products_id})
	end

	def self.transactions_by_not_products(products_id)
	  	where.not({product_id: products_id})
	end

	def self.transactions_by_carts(carts_id)
	  	where({cart_id: carts_id})
	end

	def self.transactions_by_not_carts(carts_id)
	  	where.not({cart_id: carts_id})
	end

	def self.transactions_by_amounts(amount)
	  	where("amount = ?", amount)
	end
	def self.transactions_by_amounts_greater(amount)
	  	where("amount >= ?", amount)
	end
	def self.transactions_by_amounts_less(amount)
	  	where("amount <= ?", amount)
	end


end
