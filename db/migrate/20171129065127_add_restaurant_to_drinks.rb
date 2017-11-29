class AddRestaurantToDrinks < ActiveRecord::Migration[5.1]
  def change
    add_reference :drinks, :restaurant, foreign_key: true
  end
end
