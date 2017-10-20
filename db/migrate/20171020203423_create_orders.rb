class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :full_name
      t.string :phone_number
      t.string :location
      t.string :street
      t.text :location_description
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
