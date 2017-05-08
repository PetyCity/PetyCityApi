class AddNewValuesToCompanies < ActiveRecord::Migration[5.0]
  def change    
    add_column :companies, :c_votes_like, :integer,default:0
    add_column :companies, :c_votes_dislike, :integer,default:0
  end
end
