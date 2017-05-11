class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.integer :document
      t.string :city, limit: 20 
      t.integer :phone, limit: 8
      t.text :message   
      t.boolean :resolved, default: false   
      t.references :user
      t.timestamps
    end
  end
end
