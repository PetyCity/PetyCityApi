class CommentProduct < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :user , presence: true

  #ver comentarios en especifico
  def self.comment_by_ids(id)
    where(comment_products: {
       id:  id
      })
  end
  
  #ver comentarios  por cada usuario
  def self.comment_product_by_user(user)
    where(comment_products: {
        user_id:  user
      })
  end


   #ver todos los comentarios
  def self.all_comments()
   	 select("comment_products.*") 
  end

end
