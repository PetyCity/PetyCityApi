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

	def self.load_images(page = 1, per_page = 10)
    	paginate(:page => page, :per_page => per_page)
	end

	def self.image_by_id(id)
		find_by_id(id)
	end

	def self.images_by_ids(ids, page = 1, per_page = 10)
		load_images(page,per_page)
		  .where({id: ids })
	end

	def self.images_by_not_ids(ids, page = 1, per_page = 10)
		load_images(page,per_page)
		  .where.not({id: ids })
	end

	def self.images_by_name(name_image, page = 1, per_page = 10)
		where({name_image: name_image}).paginate(:page => page, :per_page => per_page)
	end

	def self.images_by_products(products_id, page = 1, per_page = 10)
		where({product_id: products_id}).paginate(:page => page, :per_page => per_page)
	end

	def self.images_by_not_products(products_id, page = 1, per_page = 10)
		where.not({product_id: products_id}).paginate(:page => page, :per_page => per_page)
	end

	def self.product()
		Product.where('product_id = ?', self.product_id)
	end

end
