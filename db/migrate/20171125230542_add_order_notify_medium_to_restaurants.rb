class AddOrderNotifyMediumToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :order_notify_medium, :integer
  end
end
