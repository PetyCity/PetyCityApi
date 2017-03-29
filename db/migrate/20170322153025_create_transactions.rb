class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :product, foreign_key: true, null:false
      t.references :cart, foreign_key: true, null:false
      t.integer :amount, limit: 8, null:false

      t.timestamps
    end
  end
end
