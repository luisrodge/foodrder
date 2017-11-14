class AddRestaurantNameToRestaurantRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurant_requests, :restaurant_name, :string
  end
end
