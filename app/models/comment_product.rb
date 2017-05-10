class CommentProduct < ApplicationRecord
  acts_as_votable
  belongs_to :product
  belongs_to :user
  validates :user , presence: true
  validates :body_comment_product, presence: true ,allow_blank: false
  default_scope {order("created_at ASC")} 
  #ver comentarios en especifico
  def self.comment_by_ids(id, page = 1, per_page = 10)
    where(comment_products: {
       id:  id
      })
      .paginate(:page => page,:per_page => per_page)
  end

  #ver comentarios  por cada usuario
  def self.comment_product_by_user(user, page = 1, per_page = 10)
    where(comment_products: {
        user_id:  user
      })
      .paginate(:page => page,:per_page => per_page)
  end


   #ver todos los comentarios
  def self.all_comments(page = 1, per_page = 10)
   	 select("comment_products.*").paginate(:page => page,:per_page => per_page)
  end


  def self.comments_product_by_products(pro)
    where( comment_products:{
        product_id: pro
    })
  end

   def self.comment_product_by_product(pro,id)
    where(comment_products:{
      product_id: pro 
      }).find_by_id(id)

  end

end
