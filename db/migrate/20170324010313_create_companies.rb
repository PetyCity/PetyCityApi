class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.integer :nit
      t.string :name
      t.string :address
      t.string :city
      t.integer :phone
      t.boolean :permission
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
