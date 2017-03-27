class CreateComentProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :coment_products do |t|
      t.text :body, null:false, default:""
      t.references :product, foreign_key: true, null:false
      t.references :user, foreign_key: true, null:false

      t.timestamps
    end
  end
end
