class CreateCommentPublications < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_publications do |t|
      t.text :body_comment_Publication, null: false, default: ""
      t.references :publication, foreign_key: true, null:  false
      t.references :user, foreign_key: true, null:  false
      t.integer :c_pu_votes_like,default:0
      t.integer :c_pu_votes_dislike,default:0
      
      t.timestamps
    end
  end
end
