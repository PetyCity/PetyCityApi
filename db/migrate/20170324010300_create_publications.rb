class CreatePublications < ActiveRecord::Migration[5.0]
  def change
    create_table :publications do |t|
      t.string :title, null: false
      t.text :body_publication, null: false, default: ""
      t.references :user, foreign_key: true, null:  false
      t.string :image_publication 
      t.integer :p_votes_like ,default:0
      t.integer :p_votes_dislike ,default:0     
 
      t.timestamps
    end
  end
end
