class CreateCommentPublications < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_publications do |t|
      t.text :body, null: false, default: ""
      t.references :publication, foreign_key: true, null:  false
      t.references :user, foreign_key: true, null:  false

      t.timestamps
    end
  end
end
