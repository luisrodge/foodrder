class Supplier::OrderFragmentsController < Supplier::BaseController
  before_action :set_order_fragment
  before_action :should_redirect

  def show
  end

  def archive
    @order_fragment.update_attributes(status: 1, archived_on: DateTime.now)
    redirect_to supplier_dashboard_path, notice: "Order has been successfully archived."
  end

  def order_ready
    @order_fragment.update_attributes(status: 1, archived_on: DateTime.now)
    DispatchCustomerSmsJob.perform_later(@order_fragment)
    redirect_to supplier_dashboard_path, notice: "Order has been archived and a pickup ready message has been dispatched to the customer."
  end

  private

  def set_order_fragment
    @order_fragment = OrderFragment.find(params[:id])
  end

  def should_redirect
    if @order_fragment.restaurant != @current_restaurant
      redirect_to supplier_dashboard_path
    elsif @order_fragment.archived?
      redirect_to supplier_archive_path(@order_fragment)
    end
  end

end
