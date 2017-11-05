class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :cart_fragments, dependent: :destroy

  monetize :total_cents


  def cart_item_exist?(cart_item_params)
    cart_items.where(food_id: cart_item_params[:food_id]).any?
  end

  def restaurant_cart_fragment?(restaurant)
    cart_fragments.where(restaurant_id: restaurant.id).any?
  end

  # Checks if a cart has delivery selected for restaurant orders
  def delivery_selected?
    cart_fragments.where(delivery: true).any?
  end

  # Calculate total of all CartItem records in cart
  def cart_total
    total = 0
    cart_items.each do |cart_item|
      total += cart_item.total
    end
    total
  end

  # Update Cart total after any made changes to CartItem records
  def update_total
    update_attributes(total: cart_total)
  end
end
