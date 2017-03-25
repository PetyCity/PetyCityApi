class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.boolean :status
      t.integer :value
      t.integer :amount
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
