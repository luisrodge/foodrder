class RemoveOrderMediumFromRestaurants < ActiveRecord::Migration[5.1]
  def change
    remove_column :restaurants, :order_medium, :integer
  end
end
