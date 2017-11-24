class CreateSpecials < ActiveRecord::Migration[5.1]
  def change
    create_table :specials do |t|
      t.string :name
      t.datetime :selling_date
      t.text :description
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
