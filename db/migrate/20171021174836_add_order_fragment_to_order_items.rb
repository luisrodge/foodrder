class AddOrderFragmentToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :order_fragment, foreign_key: true
  end
end
