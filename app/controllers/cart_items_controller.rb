class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:update, :destroy]
  before_action :set_food, only: :create

  # Adding a food/drink order to cart
  def create
    if @cart.cart_items.where(food_id: @food).none?
      if @cart.create_cart_item(@food)
        flash[:success] = 'Food added to cart successfully. What about something to drink?'
      else
        flash[:warning] = 'Something went wrong. Food could not be added to cart.'
      end
    else
      flash[:warning] = 'Food already added to cart. Try adding another food instead.'
    end
    redirect_to restaurant_drinks_path(@food.restaurant, cf_id: CartFragment.find_by_restaurant_id(@food.restaurant).id)
  end

  def update
    @cart_item.update_item(cart_item_params[:quantity])
    redirect_to cart_path, notice: "Order quantity successfully updated"
  end

  def destroy
    @cart_item.remove_item
    redirect_to cart_path, notice: "Food successfully removed from cart"
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:food_id, :itemable_id, :quantity)
  end

  def set_cart_item
    @cart_item ||= CartItem.find(params[:id])
  end

  def set_food
    @food ||= Food.find(cart_item_params[:food_id])
  end
end
