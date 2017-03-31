class Category < ApplicationRecord

	default_scope {order("categories.created_at desc")}
  
	validates :name_category, presence:true, uniqueness: true
	 
	has_many :products, through: :category_products
	has_many :category_products

  	

    #ver todas las categorias
  	def self.all_categories()
		select("categories.*")
  	end

  	#categoria por nombre

  	def self.categories_by_name(name)	
      Category.where("categories.name LIKE ?", "#{name.downcase}")
  	end
    

    #categoria por id
    def self.categories_by_ids(ids)
      where(categories:{
        id: ids
      })
  	end  


end
