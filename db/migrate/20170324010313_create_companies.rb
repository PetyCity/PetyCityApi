class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.integer :nit , limit: 8
      t.string :name
      t.string :address, limit: 30
      t.string :city, limit: 20 
      t.integer :phone, limit: 8
      t.boolean :permission, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
