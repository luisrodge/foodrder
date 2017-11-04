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

  # Total of everything in client cart
  def cart_total
    total = 0
    cart_items.each do |cart_item|
      total += cart_item.food.price
    end
    total
  end
end
