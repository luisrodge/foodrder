class RemoveOrderNotifyTypeFromRestaurants < ActiveRecord::Migration[5.1]
  def change
    remove_column :restaurants, :order_notify_type, :integer
  end
end
