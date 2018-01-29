# Cart is associated to CartItems and CartFragments.
# CartItems are simply the items being ordered and
# CartFragments segregates those items by their respective restaurant.
class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :cart_fragments, dependent: :destroy

  monetize :total_cents

  # Create a CartItem record upon adding a Food/Drink item to Cart
  # and associate created record with a CartFragment record
  def create_cart_item(itemable, variant, choice, additions, quantity)
    quantity = quantity.nil? ? 1 : quantity
    restaurant = itemable.restaurant
    transaction do
      if cart_items.where(itemable: itemable).any?
        cart_items.where(itemable: itemable).first.increment!(:quantity)
      else
        cart_fragment = if restaurant_cart_fragment?(restaurant)
                          cart_fragments.where(restaurant: restaurant).first
                        else
                          cart_fragments.create(restaurant: restaurant)
                        end
        price = if itemable.price == 0
                  variant.price_cents
                else
                  itemable.price_cents
                end
        cart_item = cart_items.create!(itemable: itemable,
                                       variant: variant,
                                       choice: choice,
                                       quantity: quantity,
                                       cart_fragment: cart_fragment,
                                       total: price)
        cart_item.addition_ids = additions
      end
      update_total
    end
  end

  def count
    cart_fragments.count
  end

  def cart_item_exist?(cart_item_params)
    cart_items.where(itemable_id: cart_item_params[:itemable_id]).any?
  end

  def restaurant_cart_fragment?(restaurant)
    cart_fragments.where(restaurant_id: restaurant.id).any?
  end

  # Checks if a cart has delivery selected for restaurant orders
  def delivery_selected?
    cart_fragments.where(delivery: true).any?
  end

  # Calculate total of all CartItem records in cart
  # Takes into account variants and additions prices
  def cart_total
    total = 0
    cart_items.each do |cart_item|
      total += cart_item.cart_item_total
    end
    total
  end

  # Update Cart total after any made changes to CartItem records
  def update_total
    update_attributes!(total: cart_total)
  end
end
