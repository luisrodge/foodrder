class CartsController < ApplicationController
  before_action :decorate_cart
  layout 'minimal'

  def show
    @cart_items = CartItemDecorator.decorate_collection(@cart.cart_items)
    @cart_fragments = CartFragmentDecorator.decorate_collection(@cart.cart_fragments)
  end

  private

  def decorate_cart
    @cart = @cart.decorate
  end
end
