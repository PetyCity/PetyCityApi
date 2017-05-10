class AddNewValuesToCommentProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :comment_products, :c_pro_votes_like, :integer,default:0
    add_column :comment_products, :c_pro_votes_dislike, :integer,default:0
  end
end
