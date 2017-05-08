class AddNewValuesToPublications < ActiveRecord::Migration[5.0]
  def change
    add_column :publications, :p_votes_like, :integer,default:0
    add_column :publications, :p_votes_dislike, :integer,default:0
  end
end
