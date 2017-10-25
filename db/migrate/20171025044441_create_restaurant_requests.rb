class CreateRestaurantRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurant_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :mobile_number
      t.string :restaurant_phone_number
      t.integer :number_of_employees
      t.string :location
      t.string :street_name
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
