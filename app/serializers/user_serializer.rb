class UserSerializer < ActiveModel::Serializer

  
    attribute :id, if: :render_id?
    attribute :email, if: :render_email?
    attribute :document, if: :render_document?

    attribute :name_user , if: :render_name_user?
    attribute :block,  if: :render_block?
    attribute :sendEmail, if: :render_sendEmail?
    attribute :rol, if: :render_rol?
    attribute :active,if: :render_active?
    attribute :image,if: :render_image?
    has_one :cart, dependent: :destroy
    has_one :company, dependent: :destroy   

    has_many :publications, dependent: :destroy
    has_many :comment_Publications, dependent: :destroy
    has_many :comment_Products, dependent: :destroy
    has_many :c_products, through: :company,source: :products
    has_many :transactions, through: :cart
     has_many :sales, through: :cart
    has_many :s_products , through: :sales, source: :product
    has_many :t_products , through: :transactions, source: :product
    has_many :co_sales, through: :c_products, source: :sales

  
  def render_id?
    render?(instance_options[:render_attribute].split(","),"users.id","id")
  end

  def render_email?
    render?(instance_options[:render_attribute].split(","),"users.email","email")
  end

  def render_document?
    render?(instance_options[:render_attribute].split(","),"users.document","description")
  end

  def render_name_user?
    render?(instance_options[:render_attribute].split(","),"users.name_user","name_user")
  end



  def render_block?
    render?(instance_options[:render_attribute].split(","),"users.block","block")
  end

  def render_sendEmail?
    render?(instance_options[:render_attribute].split(","),"users.sendEmail","sendEmail")
  end

  def render_rol?
    render?(instance_options[:render_attribute].split(","),"users.rol","rol")
  end

  def render_active?
    render?(instance_options[:render_attribute].split(","),"users.active","active")
  end

  def render_image?
    render?(instance_options[:render_attribute].split(","),"users.image","image")
  end


  def render?(values,name1,name2)
      values = values.map {|v| v.downcase}   
      if values[0] != "user"
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
