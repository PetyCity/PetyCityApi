class CommentPublication < ApplicationRecord
  belongs_to :publication
  belongs_to :user
  validates :body_comment, presence: true ,allow_blank: false
  validates :user , presence: true
  #COMENTARIOS de alguien en especifico 
#def self.users_by_comments(user)
 #   joins(comment_Publications: :publication)
  #  .select("users.*","comment_Publications.*","publications.title")      
   #  .where(users: {
    #    id: user
     # })      
# end
  
end
