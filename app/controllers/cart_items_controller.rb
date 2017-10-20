class CartItemsController < ApplicationController
  before_action :set_restaurant, except: [:index, :destroy]

  # Handle adding a food order to cart
  def create
    if !@cart.cart_item_exist?(cart_item_params)
      if @cart.restaurant_cart_fragment?(@restaurant)
        cart_fragment = @cart.cart_fragments.where(restaurant: @restaurant).first
      else
        cart_fragment = @cart.cart_fragments.create(restaurant: @restaurant)
      end

      @cart.cart_items.create(food_id: cart_item_params[:food_id],
                              quantity: 1, cart_fragment: cart_fragment)

      @cart.update_attributes(total: @cart.cart_total)
    else
      flash[:error] = 'Food could not be added to cart'
    end
    redirect_to request.referer
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:food_id, :quantity)
  end

  def set_restaurant
    @restaurant = Food.find(cart_item_params[:food_id]).restaurant
  end
end