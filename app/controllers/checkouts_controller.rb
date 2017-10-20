class CheckoutsController < ApplicationController
  before_action :reject_checkout

  def new
    @order = Order.new
    @cart_fragments = CartFragmentDecorator.decorate_collection(@cart.cart_fragments)
  end

  def create
    @order = Order.new(checkout_params)

    if @order.valid?
      @cart.cart_fragments.each do |cart_fragment|
        delivery = false
        if checkout_params[:delivery].include?(cart_fragment.restaurant.id)
          delivery = true
        end

        order = Order.create(checkout_params
                                 .merge(restaurant_id: cart_fragment.restaurant.id,
                                        delivery: delivery))
        cart_fragment.cart_items.each do |cart_item|
          order.order_items.create(food: cart_item.food, quantity: cart_item.quantity)
        end
      end
      @cart.destroy
      cookies.delete(:cart)

      flash[:success] = 'Your order had been sent.'
      redirect_to root_path
    else
      @cart_fragments = CartFragmentDecorator.decorate_collection(@cart.cart_fragments)
      @cart_items = CartItemDecorator.decorate_collection(@cart.cart_items)
      render :new
    end
  end

  private

  def checkout_params
    params.require(:order).permit(:full_name, :phone_number, :location,
                                  :street, :location_description, :delivery)
  end

  # Prevent user from checking out if the cart is empty
  # or if the are attempting to checkout out with a cart
  # other than the one stored on the client.
  def reject_checkout
    if @cart.cart_items.none? || @cart.id != params[:cart_id].to_i
      redirect_to root_path
    end
  end
end
