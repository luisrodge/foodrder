class CheckoutsController < ApplicationController
  before_action :reject_checkout

  def new
    @order = Order.new
    @cart_fragments = CartFragmentDecorator.decorate_collection(@cart.cart_fragments)
  end

  # @TODO wrap in transaction block
  def create
    @order = Order.new(checkout_params)

    if @order.valid?
      # Create the parent Order record and associate both OrderFragment
      # and OrderItem records to it.
      order = Order.create(checkout_params.merge(total: @cart.total))

      @cart.cart_fragments.each do |cart_fragment|
=begin
        delivery = false
        if checkout_params[:delivery].include?(cart_fragment.restaurant.id)
          delivery = true
        end
=end
        # Create segregation of order items by restaurant using OrderFragment.
        # Associate OrderFragment with parent Order record.
        order_fragment = OrderFragment.create(order: order,
                                              restaurant: cart_fragment.restaurant)

        # Assign each OrderItem to it's appropriate OrderFragment.
        cart_fragment.cart_items.each do |cart_item|
          order.order_items.create(food: cart_item.food,
                                   quantity: cart_item.quantity,
                                   order_fragment: order_fragment)
        end
      end
      @cart.destroy
      cookies.delete(:cart)

      flash[:success] = 'Your order had been sent successfully. We will reach out to you soon.'
      redirect_to root_path
    else
      @cart_fragments = CartFragmentDecorator.decorate_collection(@cart.cart_fragments)
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
