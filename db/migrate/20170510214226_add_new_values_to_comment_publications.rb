class AddNewValuesToCommentPublications < ActiveRecord::Migration[5.0]
  def change
    add_column :comment_publications, :c_pu_votes_like, :integer,default:0
    add_column :comment_publications, :c_pu_votes_dislike, :integer,default:0
  end
end
