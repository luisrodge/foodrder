class AddOrderNotifyTypeToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :order_notify_type, :integer
  end
end
