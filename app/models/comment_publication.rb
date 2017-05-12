class CommentPublication < ApplicationRecord
  belongs_to :publication
  belongs_to :user
  validates :body_comment_Publication, presence: true ,allow_blank: false,length: { in: 1..300 }
  validates :user , presence: true
  acts_as_votable


  #Queries
  default_scope {order("created_at ASC")}
  #ver comentarios en especifico
  def self.comment_publication(id)
    where(comment_publications: {
       id:  id
      })
  end

  #ver comentarios  por cada usuario
  def self.comment_publication_by_user(user, page = 1, per_page = 10)
    where(comment_publications: {
        user_id:  user
      }).paginate(:page => page,:per_page => per_page)
  end
   #ver comentarios  por cada publicacion
  def self.comment_publication_by_publication(pu, page = 1, per_page = 10)
    where(comment_publications: {
        publication_id:  pu
      }).paginate(:page => page,:per_page => per_page)
  end

end
