class CheckoutsController < ApplicationController
  before_action :reject_checkout

  def new
    @order = Order.new
    @cart_items = CartItemDecorator.decorate_collection(@cart.cart_items)
    @cart_fragments = CartFragmentDecorator.decorate_collection(@cart.cart_fragments)
  end

  private

  # Prevent user from checking out if the cart is empty
  # or if the are attempting to checkout out with a cart
  # other than the one stored on the client side.
  def reject_checkout
    if @cart.cart_items.none? || @cart.id != params[:cart_id].to_i
      redirect_to root_path
    end
  end
end
