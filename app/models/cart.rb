class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :cart_fragments, dependent: :destroy

  monetize :total_cents

  # Create a CartItem record upon adding a Food to Cart
  # and associate created record with a CartFragment record
  def create_cart_item(food)
    restaurant = food.restaurant
    transaction do
      if restaurant_cart_fragment?(restaurant)
        cart_fragment = cart_fragments.where(restaurant: restaurant).first
      else
        cart_fragment = cart_fragments.create(restaurant: restaurant)
      end
      cart_items.create(food: food, quantity: 1,
                        cart_fragment: cart_fragment,
                        total: food.price)
      update_total
    end
  rescue StandardError
    return false
  end

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
