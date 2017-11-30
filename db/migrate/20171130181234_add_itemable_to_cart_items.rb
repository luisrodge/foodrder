class AddItemableToCartItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :cart_items, :itemable, polymorphic: true, index: true
  end
end
