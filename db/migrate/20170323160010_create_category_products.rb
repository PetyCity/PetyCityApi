class CreateCategoryProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :category_products do |t|
      t.references :product, foreign_key: true, null:false
      t.references :category, foreign_key: true, null:false

      t.timestamps
    end
    add_index :category_products,[:product_id, :category_id], unique: true
  end
end
