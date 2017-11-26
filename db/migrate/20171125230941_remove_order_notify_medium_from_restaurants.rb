class RemoveOrderNotifyMediumFromRestaurants < ActiveRecord::Migration[5.1]
  def change
    remove_column :restaurants, :order_notify_medium, :integer
  end
end
