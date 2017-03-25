class CommentPublication < ApplicationRecord
  belongs_to :publication
  belongs_to :user
   validates :body, presence: true ,allow_blank: false

  
end
