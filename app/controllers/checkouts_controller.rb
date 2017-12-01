class CheckoutsController < ApplicationController
  before_action :reject_checkout
  layout 'minimal'

  def new
    @order = Order.new
    @cart_fragments = @cart.cart_fragments.order("created_at DESC").page(params[:page]).per(1)
  end

  def create
    @order = Order.new(checkout_params)

    if @order.valid?
      Order.checkout(@order, @cart)
      @cart.destroy
      cookies.delete(:cart)
      flash[:success] = 'Your order had been sent successfully.'
      redirect_to root_path
    else
      @cart_fragments = CartFragmentDecorator.decorate_collection(@cart.cart_fragments)
      render :new
    end
  end

  private

  def checkout_params
    params.require(:order).permit(:phone_number, :delivery_address, :full_name,
                                  :delivery, :total).merge(total: @cart.total)
  end

  # Prevent customer from checking out if the cart is empty
  # or if the are attempting to checkout out with a cart
  # other than the one stored on the client.
  def reject_checkout
    if @cart.cart_items.none? || @cart.id != params[:cart_id].to_i
      redirect_to root_path
    end
  end

  def message_restaurant(order_fragment)
    EngineSparkService.new(order_fragment).message_restaurant
  end
end
