class CheckoutsController < ApplicationController
  before_action :reject_checkout
  before_action :set_cart_fragments
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
      flash[:success] = 'Your order had been sent successfully. Thanks for ordering with foodrder.bz'
      redirect_to root_path
    else
      flash[:danger] = "Your order could not be sent. Make sure you are filling out all the required fields & that you are entering valid values"
      redirect_to new_cart_checkout_path(@cart)
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

  def set_cart_fragments
    @cart_fragments = @cart.cart_fragments.order("created_at DESC").page(params[:page]).per(1)
  end
end
