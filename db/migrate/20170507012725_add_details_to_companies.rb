class AddDetailsToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :longitude, :decimal
    add_column :companies, :latitude, :decimal
    add_column :companies, :type, :integer
  end
end
