class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :name_image, null: false
      t.references :product, foreign_key: true, null: false

      t.timestamps
    end
  end
end

