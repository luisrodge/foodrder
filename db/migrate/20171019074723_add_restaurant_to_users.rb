class AddRestaurantToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :restaurant, foreign_key: true
  end
end
