class PublicationSerializer < ActiveModel::Serializer
    
  attribute :id, if: :render_id?
  attribute :title, if: :render_title?
 
  attribute :body_publication , if: :render_body_publication?
  attribute :user_id,  if: :render_user_id?
  attribute :image_publication, if: :render_image_publication?
  belongs_to :user
  has_many :comment_Publications, dependent: :destroy  
  has_many :c_user, through: :comment_Publications,source: :user
	
  def render_id?
    render?(instance_options[:render_attribute].split(","),"products.id","id")
  end

  def render_title?
    render?(instance_options[:render_attribute].split(","),"products.title","title")
  end

 
  def render_body_publication?
    render?(instance_options[:render_attribute].split(","),"products.body_publication","body_publication")
  end



  def render_user_id?
    render?(instance_options[:render_attribute].split(","),"products.user_id","user_id")
  end

  def render_image_publication?
    render?(instance_options[:render_attribute].split(","),"products.image_publication","image_publication")
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
