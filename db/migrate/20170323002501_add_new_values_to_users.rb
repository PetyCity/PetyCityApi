class AddNewValuesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cedula, :integer
    add_column :users, :name, :string
    add_column :users, :block, :boolean
    add_column :users, :sendEmail, :boolean
    add_column :users, :rol, :integer
    add_column :users, :image, :integer
  end
end
