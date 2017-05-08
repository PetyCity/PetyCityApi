class AddNewValuesToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :votes_number, :integer,default:0
    add_column :products, :votes_average, :float,default:0
  end
end
