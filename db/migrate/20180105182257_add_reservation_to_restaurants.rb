class AddReservationToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :reservation, :boolean, default: false
  end
end
