class AddTotalToCartItems < ActiveRecord::Migration[5.1]
  def change
    add_monetize :cart_items, :total
  end
end
