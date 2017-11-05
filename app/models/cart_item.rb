class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food
  belongs_to :cart_fragment

  # Remove a CartItem and associations then update Cart total
  def remove_item
    existing_cart = cart
    if cart_fragment.cart_items.count < 2
      cart_fragment.destroy
    else
      destroy
    end
    existing_cart.update_total
  end

  # Update a CartItem quantity then update Cart total
  def update_item(quantity)
    existing_cart = cart
    update_attributes(quantity: quantity)
    existing_cart.update_total
  end

  # Calculate single CartItem total
  def total
    food.price * quantity
  end
end
