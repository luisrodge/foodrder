class AddOrderFragmentToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :order_fragments, foreign_key: true
  end
end
