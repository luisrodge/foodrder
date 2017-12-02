class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:update, :destroy]
  before_action :set_itemable, only: :create

  # Adding a food/drink order to cart
  def create
    if @cart.cart_items.where(itemable_id: @itemable).none?
      if @cart.create_cart_item(@itemable)
        if @itemable.restaurant.drinks.any?
          if CartItem.find_by_itemable_id(@itemable).itemable_type == 'Food'
            flash[:success] = 'Food added to cart successfully. What about ordering something to drink?'
          else
            flash[:info] = 'Drink added to cart successfully.'
          end
          redirect_to restaurant_drinks_path(@itemable.restaurant) and return
        else
          flash[:success] = 'Food added to cart successfully.'
        end
      else
        flash[:warning] = 'Something went wrong. Food could not be added to cart.'
      end
    else
      flash[:warning] = 'Food already added to cart. Try adding another food instead.'
    end
    redirect_to cart_path
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

  def set_itemable
    resource, id = request.path.split('/')[1, 2]
    @itemable = resource.singularize.classify.constantize.find(id)
  end
end
