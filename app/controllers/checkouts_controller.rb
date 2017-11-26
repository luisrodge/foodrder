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
        # Create segregation of order items by restaurant using OrderFragment.
        # Associate OrderFragment with parent Order record.
        order_fragment = OrderFragment.create(order: order,
                                              restaurant: cart_fragment.restaurant,
                                              delivery: cart_fragment.delivery)

        # Assign each OrderItem to it's appropriate OrderFragment.
        cart_fragment.cart_items.each do |cart_item|
          order.order_items.create(food: cart_item.food,
                                   quantity: cart_item.quantity,
                                   order_fragment: order_fragment)
        end
        # Dispatch restaurant text message containing order details
        # if restaurant opted for text message notification of new orders.
        if order_fragment.restaurant.text_message?
          message_restaurant(order_fragment)
          if order_fragment.delivery?
            order_fragment.update_attributes(status: 2)
          else
            order_fragment.update_attributes(status: 1)
          end

          @order.update_attributes(status: 1) if @order.order_fragments.count == 1
        end
      end
      @cart.destroy
      cookies.delete(:cart)

      # Send new order email to admins
      # OrderMailer.send_new_order_email(Admin.last).deliver

      flash[:success] = 'Your order had been sent successfully.'
      redirect_to root_path
    else
      @cart_fragments = CartFragmentDecorator.decorate_collection(@cart.cart_fragments)
      render :new
    end
  end

  private

  def checkout_params
    params.require(:order).permit(:phone_number, :location, :location_description,
                                  :delivery)
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
