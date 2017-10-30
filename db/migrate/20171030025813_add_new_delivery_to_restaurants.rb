class AddNewDeliveryToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :delivery, :boolean, default: false
  end
end
