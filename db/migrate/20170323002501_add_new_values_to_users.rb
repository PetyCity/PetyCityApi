class AddNewValuesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cedula, :integer
    add_column :users, :name_user, :string
    add_column :users, :block, :boolean, default: false
    add_column :users, :sendEmail, :boolean, default: false
    add_column :users, :rol, :integer
    add_column :users, :image, :integer
  end
end
