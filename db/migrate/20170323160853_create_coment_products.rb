class CreateComentProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :coment_products do |t|
      t.text :body
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
