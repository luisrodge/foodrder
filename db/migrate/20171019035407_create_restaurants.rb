class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.string :street
      t.string :phone_number
      t.text :description
      t.boolean :setup

      t.timestamps
    end
  end
end
