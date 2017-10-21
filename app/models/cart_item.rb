class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food
  belongs_to :cart_fragment

  def remove_item
    existing_cart = cart

    if cart_fragment.cart_items.count < 2
      cart_fragment.destroy
    else
      destroy
    end

    existing_cart.update_attributes(total: existing_cart.cart_total)
  end

  def total
    food.price * quantity
  end
end
