class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.references :user, foreign_key: true, null: false
      t.float :total_price, limit: 8, null: false
      t.boolean :active,default:true
      t.timestamps
    end
  end
end
