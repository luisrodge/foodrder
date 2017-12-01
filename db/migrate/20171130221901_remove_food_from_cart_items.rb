class RemoveFoodFromCartItems < ActiveRecord::Migration[5.1]
  def change
    remove_reference :cart_items, :food, foreign_key: true
  end
end
