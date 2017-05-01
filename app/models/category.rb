class Category < ApplicationRecord

	default_scope {order("categories.created_at desc")}

	validates :name_category, presence:true, uniqueness: true

	has_many :products, through: :category_products
	has_many :category_products



    #ver todas las categorias
  	def self.all_categories(page = 1, per_page = 10)
		select("categories.*")
		.paginate(:page => page,:per_page => per_page)
  	end

  	#categoria por nombre


  	def self.categories_by_name(name, page = 1, per_page = 10)
      Category.where("categories.name LIKE ?", "#{name.downcase}")
			.paginate(:page => page,:per_page => per_page)
    end
  	
    def self.categories_by_name(name)	
      Category.where("categories.name_category ILIKE ?", name)
  	end




    #categoria por id
    def self.categories_by_id(ids, page = 1, per_page = 10)
      where(categories:{
        id: ids
      })
			.paginate(:page => page,:per_page => per_page)
  	end


end
