class AddItemableToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :order_items, :itemable, polymorphic: true, index: true
  end
end
