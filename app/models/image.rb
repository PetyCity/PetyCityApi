class Image < ApplicationRecord
  #RELATIONSHIPS
	belongs_to :product

	#VALIDATES
	validates :name, presence: true, length: { in: 3..20 }, uniqueness: true

	#SCOPES

	default_scope {order(name: :asc)}
	scope :order_by_amount_desc, -> {order(name: :desc)}
	scope :order_by_id_asc, -> {order(id: :asc)}
  	scope :order_by_id_desc, -> {order(id: :desc)}

	#QUERIES

	def self.load_images()
    	self.all
	end

	def self.image_by_id(id)
		find_by_id(id)
	end

	def self.images_by_ids(ids)
		load_images()
		  .where({id: ids })
	end

	def self.images_by_not_ids(ids)
		load_images()
		  .where.not({id: ids })
	end

	def self.images_by_name(name_image)
		where({name_image: name_image})
	end

	def self.images_by_products(products_id)
		where({product_id: products_id})
	end

	def self.images_by_not_products(products_id)
		where.not({product_id: products_id})
	end

	def self.product(product_id)
		includes(:product)
	end

end
