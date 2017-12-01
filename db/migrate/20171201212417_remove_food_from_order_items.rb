class RemoveFoodFromOrderItems < ActiveRecord::Migration[5.1]
  def change
    remove_reference :order_items, :food, foreign_key: true
  end
end
