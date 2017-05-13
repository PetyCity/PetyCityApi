class CreateCommentProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_products do |t|
      t.text :body_comment_product
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :c_pro_votes_like,default:0
      t.integer :c_pro_votes_dislike,default:0
      t.timestamps
    end
  end
end
