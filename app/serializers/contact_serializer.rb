class ContactSerializer < ActiveModel::Serializer
    attribute :id, if: :render_id?
    attribute :email, if: :render_email?
    attribute :document, if: :render_document?
    attribute :city,  if: :render_city?
    attribute :phone, if: :render_phone?
    attribute :created_at, if: :render_created_at?
    attribute :user_id,if: :render_user_id?
    attribute :resolved,if: :render_resolved?
    
    belongs_to :user
 

  def render_id?
    render?(instance_options[:render_attribute].split(","),"contacts.id","id")
  end

  def render_email?
    render?(instance_options[:render_attribute].split(","),"contacts.email","email")
  end

  def render_document?
    render?(instance_options[:render_attribute].split(","),"contacts.document","description")
  end
  def render_city?
    render?(instance_options[:render_attribute].split(","),"companies.city","city")
  end

  def render_phone?
    render?(instance_options[:render_attribute].split(","),"companies.phone","phone")
  end
  def render_user_id?
      render?(instance_options[:render_attribute].split(","),"companies.user_id","user_id")
  end
  def render_created_at?
    render?(instance_options[:render_attribute].split(","),"contacts.created_at","created_at")
  end 
   def render_resolved?
    render?(instance_options[:render_attribute].split(","),"contacts.resolved","resolved")
  end
  
  def render?(values,name1,name2)
      values = values.map {|v| v.downcase}   
      if values[0] != "contact"
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
