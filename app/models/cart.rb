class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :cart_fragments, dependent: :destroy

  def cart_item_exist?(cart_item_params)
    cart_items.where(food_id: cart_item_params[:food_id]).any?
  end

  def restaurant_cart_fragment?(restaurant)
    cart_fragments.where(restaurant_id: restaurant.id).any?
  end

  def cart_total
    total = 0
    cart_items.each do |cart_item|
      total += cart_item.food.price
    end
    total
  end
end
