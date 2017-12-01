class CartsController < ApplicationController
  before_action :decorate_cart
  layout 'minimal'

  def show
    @cart_fragments = @cart.cart_fragments.order("created_at DESC").page(params[:page]).per(1)
    @drinks = @cart.cart_items.where(itemable_type: "Variant")
  end

  private

  def decorate_cart
    @cart = @cart.decorate
  end
end
