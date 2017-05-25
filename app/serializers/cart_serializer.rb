class CartSerializer < ActiveModel::Serializer
   
   attribute :id, if: :render_id?
   attribute :user_id, if: :render_user_id?
   attribute :total_price, if: :render_total_price?
   attribute :active, if: :render_active?
   has_many :transactions
   has_many :sales
   has_many :products, through: :transactions



    def render_id?
    	render?(instance_options[:render_attribute].split(","),"carts.id","id")
  	end

	  def render_user_id?
	    render?(instance_options[:render_attribute].split(","),"carts.product_id","product_id")
	  end

	  def render_total_price?
	    render?(instance_options[:render_attribute].split(","),"carts.total_price","total_price")
	  end

	  def render_active?
	    render?(instance_options[:render_attribute].split(","),"carts.active","active")
	  end


	def render?(values,name1,name2)
      values = values.map {|v| v.downcase}   
      if values[0] != "cart"
        true
      elsif values.length == 1
        true
      elsif values.include?(name1) || values.include?(name2)
        true
      else
        false
      end
   end


  
 
end
