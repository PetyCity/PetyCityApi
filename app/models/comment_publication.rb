class CommentPublication < ApplicationRecord
  belongs_to :publication
  belongs_to :user
  validates :body_comment_Publication, presence: true ,allow_blank: false
  validates :user , presence: true
  
  
  
  #Queries
  
  #ver comentarios en especifico
  def self.comment_publication(id)
    where(comment_publications: {
       id:  id
      })
  end
  
  #ver comentarios  por cada usuario
  def self.comment_publication_by_user(user)
    where(comment_publications: {
        user_id:  user
      })
  end
   #ver comentarios  por cada publicacion
  def self.comment_publication_by_publication(pu)
    where(comment_publications: {
        publication_id:  pu
      })
  end  
  
end
