class CreateCommentPublications < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_publications do |t|
      t.text :body
      t.references :publication, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
