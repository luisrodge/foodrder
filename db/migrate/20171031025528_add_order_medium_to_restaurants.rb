class AddOrderMediumToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :order_medium, :integer, default: 0
  end
end
