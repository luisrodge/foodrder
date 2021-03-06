class CartItemsController < ApplicationController
  before_action :set_itemable, only: :create
  before_action :should_redirect, only: :create
  before_action :set_cart_item, only: [:update, :destroy]
  before_action :set_variant, only: :create
  before_action :set_choice, only: :create

  # Adding a food/drink order to cart
  def create
    if @cart.create_cart_item(@itemable,
                              @variant,
                              @choice,
                              cart_item_params[:addition_ids],
                              cart_item_params[:quantity])
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
    redirect_to cart_path
  end

  def update
    if @cart_item.update_item(cart_item_params)
      redirect_to cart_path, notice: "Cart item successfully updated"
    else
      flash[:danger] = "Cart item could not be updated"
      redirect_to cart_path
    end
  end

  def destroy
    @cart_item.remove_item
    redirect_to cart_path, notice: "Cart item successfully removed from cart"
  end

  private

  def should_redirect
    unless @itemable.restaurant.currently_open?
      flash[:warning] = "Your order could not be placed. #{@itemable.restaurant.name} restuarant is currently not open."
      redirect_back(fallback_location: root_path)
    end
  end

  def set_cart_item
    @cart_item ||= CartItem.find(params[:id])
  end

  def set_itemable
    resource, id = request.path.split('/')[1, 2]
    @itemable = resource.singularize.classify.constantize.find(id)
  end

  def set_variant
    @variant = if cart_item_params[:variant_id].present?
                 Variant.find(cart_item_params[:variant_id])
               end
  end

  def set_choice
    @choice = if cart_item_params[:choice_id].present?
                 Choice.find(cart_item_params[:choice_id])
               end
  end

  def cart_item_params
    params.require(:cart_item).permit(:itemable_id, :variant_id, :choice_id,
                                      :quantity, addition_ids: [])
  end

end
