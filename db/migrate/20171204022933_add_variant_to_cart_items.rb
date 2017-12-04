class AddVariantToCartItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :cart_items, :variant, foreign_key: true
  end
end
