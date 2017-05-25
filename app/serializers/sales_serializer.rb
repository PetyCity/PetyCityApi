class SalesSerializer < ActiveModel::Serializer
  attribute :product_id, if: :render_product_id?
  attribute :id, if: :render_id?
  
  attribute :cart_id, if: :render_cart_id?
  attribute :amount, if: :render_amount?

   

  belongs_to :product
  belongs_to :cart


  def render_id?
    	render?(instance_options[:render_attribute].split(","),"sales.id","id")
  	end

	  def render_product_id?
	    render?(instance_options[:render_attribute].split(","),"sales.product_id","product_id")
	  end

	  def render_cart_id?
	    render?(instance_options[:render_attribute].split(","),"sales.cart_id","cart_id")
	  end

	  def render_amount?
	    render?(instance_options[:render_attribute].split(","),"sales.amount","amount")
	  end


	def render?(values,name1,name2)
      values = values.map {|v| v.downcase}   
      if values[0] != "sale"
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
