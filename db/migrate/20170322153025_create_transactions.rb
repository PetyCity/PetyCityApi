class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :producto, foreign_key: true
      t.references :cart, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
