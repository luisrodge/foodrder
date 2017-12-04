class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :cart_fragment
  belongs_to :variant, optional: true
  belongs_to :itemable, polymorphic: true

  monetize :total_cents

  attr_accessor :delivery
  attr_accessor :drink

  validates :quantity, presence: true,
            numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 10}

  # Update a CartItem quantity then update Cart total
  def update_item(quantity)
    existing_cart = cart
    transaction do
      update_attributes!(quantity: quantity)
      update_attributes!(total: cart_item_total)
      existing_cart.update_total
    end
  rescue StandardError
    return false
  end

  # Remove a CartItem and associations then update Cart total
  def remove_item
    existing_cart = cart
    if cart_fragment.food_cart_items.count < 2
      cart_fragment.destroy
    else
      destroy
    end
    existing_cart.update_total
  end

  # Calculate single CartItem total
  def cart_item_total
    if variant.present?
      variant.price * quantity
    else
      itemable.price * quantity
    end
  end
end
