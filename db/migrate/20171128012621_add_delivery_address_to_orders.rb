class AddDeliveryAddressToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :delivery_address, :text
  end
end
