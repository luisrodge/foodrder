class RemoveRestaurantFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_reference :orders, :restaurant, foreign_key: true
  end
end
