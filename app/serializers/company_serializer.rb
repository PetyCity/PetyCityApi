class CompanySerializer < ActiveModel::Serializer
    

    attribute :id, if: :render_id?
    attribute :nit, if: :render_nit?
    attribute :name_comp, if: :render_name_comp?
    attribute :address , if: :render_address?
    attribute :city,  if: :render_city?
    attribute :phone, if: :render_phone?
    attribute :permission, if: :render_permission?
    attribute :user_id,if: :render_user_id?
	attribute :active, if: :render_active?
    attribute :image_company,if: :render_image_company?


    has_many :products, dependent: :destroy  
	belongs_to :user
  	has_many :transactions, through: :products
  	has_many :sales, through: :products
  	has_many :category_products , through: :products, dependent: :destroy  
  
	  def render_id?
    	render?(instance_options[:render_attribute].split(","),"companies.id","id")
  	  end

	  def render_nit?
	    render?(instance_options[:render_attribute].split(","),"companies.nit","nit")
	  end

	  def render_name_comp?
	    render?(instance_options[:render_attribute].split(","),"companies.name_comp","name_comp")
	  end

	  def render_address?
	    render?(instance_options[:render_attribute].split(","),"companies.address","address")
	  end



	  def render_city?
	    render?(instance_options[:render_attribute].split(","),"companies.city","city")
	  end

	  def render_phone?
	    render?(instance_options[:render_attribute].split(","),"companies.phone","phone")
	  end


	  def render_permission?
	    render?(instance_options[:render_attribute].split(","),"companies.permission","permission")
	  end

	  def render_active?
	    render?(instance_options[:render_attribute].split(","),"companies.active","active")
	  end

	   def render_user_id?
	    render?(instance_options[:render_attribute].split(","),"companies.user_id","user_id")
	  end

	  def render_image_company?
	    render?(instance_options[:render_attribute].split(","),"companies.image_company","image_company")
	  end

	  def render?(values,name1,name2)
	    values = values.map {|v| v.downcase}
	    if instance_options[:render_attribute] == "all"
	      true
	    elsif values.include?(name1) || values.include?(name2)
	      true
	    else
	      false
	    end
	  end
	end
