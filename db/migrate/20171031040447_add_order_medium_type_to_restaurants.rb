class AddOrderMediumTypeToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :order_medium_type, :integer, default: 0
  end
end
