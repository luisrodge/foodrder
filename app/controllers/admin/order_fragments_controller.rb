class Admin::OrderFragmentsController < Admin::BaseController
  before_action :set_order_fragment

  # Update the order status for a specific restaurant
  def update
    if @order_fragment.pending?
      @order_fragment.update_attributes(status: 1)
    elsif @order_fragment.customer_confirmed?
      @order_fragment.update_attributes(status: 2)
    end
    redirect_to admin_order_path(@order_fragment.order)
  end

  private

  def set_order_fragment
    @order_fragment ||= OrderFragment.find(params[:id])
  end
end
