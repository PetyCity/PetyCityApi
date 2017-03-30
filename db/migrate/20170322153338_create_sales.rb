class CreateSales < ActiveRecord::Migration[5.0]
  def change
    create_table :sales do |t|
      t.references :product, foreign_key: true, null: false
      t.references :cart, foreign_key: true, null: false
      t.integer :amount, limit: 8, null: false

      t.timestamps
    end
    add_index :transactions,[:cart_id, :product_id], unique: true
  end
end
