class Admin::OrderFragmentsController < Admin::BaseController
  before_action :set_order_fragment

  # Update the order status for a specific restaurant
  def update
    msg = ''
    if @order_fragment.pending_confirmation?
      @order_fragment.update_attributes(status: 1)
      msg = 'Order status successfully updated'
    elsif @order_fragment.restaurant_notified?
      if @order_fragment.delivery?
        @order_fragment.update_attributes(status: 3)
        @order_fragment.order.update_attributes(status: 3)
        msg = 'Order processed successfully'
      else
        @order_fragment.update_attributes(status: 2)
        msg = 'Order partially processed.'
      end
    elsif @order_fragment.pickup_ready?
      @order_fragment.update_attributes(status: 3)
      @order_fragment.order.update_attributes(status: 3)
      msg = 'Order processed successfully'
    end

    flash[:success] = msg
    redirect_to admin_order_path(@order_fragment.order)
  end

  private

  def set_order_fragment
    @order_fragment ||= OrderFragment.find(params[:id])
  end
end
