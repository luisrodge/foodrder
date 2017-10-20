class AddTotalToOrders < ActiveRecord::Migration[5.1]
  def change
    add_monetize :orders, :total
  end
end
