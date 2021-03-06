class Admin::OrderFragmentsController < Admin::BaseController
  before_action :set_order_fragment, :set_order

  # Update the order status for a specific restaurant
  def update
    msg = ''
    if @order_fragment.pending?
      if @order_fragment.delivery?
        # Mark OrderFragment and parent Order as processed
        @order_fragment.update_attributes(status: 2)
        @order.update_attributes(status: 1) unless @order.pending_order_fragments?
        # DispatchRestaurantSmsJob.perform_later(@order_fragment)
        msg = 'Order processed and archived successfully'
      else
        @order_fragment.update_attributes(status: 1)
        msg = 'Order partially processed, pending pickup ready message dispatch to customer'
      end
    elsif @order_fragment.pending_pickup_ready?
      puts "Here I am"
      @order_fragment.update_attributes(status: 2)
      @order.update_attributes(status: 1) unless @order.pending_order_fragments?
      DispatchCustomerSmsJob.perform_later(@order_fragment)
      msg = 'Order processed and archived successfully'
    end

    flash.now[:success] = msg
    redirect_to admin_orders_path
  end

  private

  def set_order_fragment
    @order_fragment ||= OrderFragment.find(params[:id])
  end

  def set_order
    @order ||= @order_fragment.order
  end

end
