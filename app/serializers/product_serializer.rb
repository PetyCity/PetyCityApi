class ProductSerializer < ActiveModel::Serializer
	#include SerializerAttribute
   # type 'data'
    attribute :id, if: :render_id?
    attribute :name_product, if: :render_name_product?
    attribute :description, if: :render_description?
    attribute :status , if: :render_status?
    attribute :value,  if: :render_value?
    attribute :amount, if: :render_amount?
    attribute :company_id, if: :render_company_id?
    attribute :active,if: :render_active?
    belongs_to :company
	has_many :comment_products
	has_many :transactions
	has_many :sales
	has_many :category_products 
	has_many :categories, through: :category_products
	has_many :users, through: :comment_products
	has_many :images
	
  def render_id?
    render?(instance_options[:render_attribute].split(","),"products.id","id")
  end

  def render_name_product?
    render?(instance_options[:render_attribute].split(","),"products.name_product","name_product")
  end

  def render_description?
    render?(instance_options[:render_attribute].split(","),"products.description","description")
  end

  def render_status?
    render?(instance_options[:render_attribute].split(","),"products.status","status")
  end



  def render_value?
    render?(instance_options[:render_attribute].split(","),"products.value","value")
  end

  def render_amount?
    render?(instance_options[:render_attribute].split(","),"products.amount","amount")
  end

  def render_company_id?
    render?(instance_options[:render_attribute].split(","),"products.company_id","company_id")
  end

  def render_active?
    render?(instance_options[:render_attribute].split(","),"products.active","active")
  end

   def render?(values,name1,name2)
      values = values.map {|v| v.downcase}   
      if values[0] != "product"
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
