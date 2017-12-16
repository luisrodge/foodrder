class AddTotalToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_monetize :order_items, :total
  end
end
