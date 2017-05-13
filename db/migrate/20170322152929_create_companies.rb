class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.integer :nit , limit: 8
      t.string :name_comp
      t.string :address, limit: 30
      t.string :city, limit: 20 
      t.integer :phone, limit: 8
      t.boolean :permission, default: false
      t.references :user, foreign_key: true
      t.boolean :active,default:true
      t.string :image_company
      t.decimal :longitude
      t.decimal :latitude
      t.integer :c_rol
      t.integer :c_votes_like,default:0
      t.integer :c_votes_dislike,default:0
      t.timestamps
    end
  end
end
