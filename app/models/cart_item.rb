class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food
  belongs_to :cart_fragment
  belongs_to :itemable, polymorphic: true

  monetize :total_cents

  attr_accessor :delivery
  attr_accessor :drink


  # Update a CartItem quantity then update Cart total
  def update_item(quantity)
    existing_cart = cart
    transaction do
      update_attributes(quantity: quantity)
      update_attributes(total: cart_item_total)
      existing_cart.update_total
    end
  end

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

  # Calculate single CartItem total
  def cart_item_total
    food.price * quantity
  end
end
