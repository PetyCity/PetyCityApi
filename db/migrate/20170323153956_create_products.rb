class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null:false
      t.text :description, null:false
      t.boolean :status, default:false
      t.integer :value, null:false
      t.integer :amount, null:false
      t.references :company, foreign_key: true , null:false

      t.timestamps
    end
  end
end
