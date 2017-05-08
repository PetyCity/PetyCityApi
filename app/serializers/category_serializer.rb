class CategorySerializer < ActiveModel::Serializer
 
  attribute :id, if: :render_id?
  attribute :name_category, if: :render_name_category?
  attribute :details, if: :render_details?
  has_many :products, through: :category_products
  has_many :category_products
    
  def render_id?
    render?(instance_options[:render_attribute].split(","),"categories.id","id")
  end

  def render_name_category?
    render?(instance_options[:render_attribute].split(","),"categories.name_category","name_category")
  end

  def render_details?
    render?(instance_options[:render_attribute].split(","),"products.details","details")
  end

  
   def render?(values,name1,name2)
      values = values.map {|v| v.downcase}       
      if values[0] != "category"
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

