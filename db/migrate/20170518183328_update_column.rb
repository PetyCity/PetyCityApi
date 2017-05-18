class UpdateColumn < ActiveRecord::Migration[5.0]
  def change

  	 change_table :products do |t|
     t.change :value, :integer
	
    end
 end
end
