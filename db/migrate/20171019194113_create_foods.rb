class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.text :description
      t.references :restaurant, foreign_key: true
      t.decimal :price
      t.references :menu, foreign_key: true
      t.string :primary_image
      t.time :estimated_cook_time

      t.timestamps
    end
  end
end
