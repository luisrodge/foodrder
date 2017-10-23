class Admin::OrdersController < Admin::BaseController
  layout 'dashboard'
  before_action :authenticate_admin!, :set_order, except: :index

  def index
    @orders = Order.pending_orders
  end

  def show
    @order = @order.decorate
    @order_fragments = @order.order_fragments
  end

  def update
    if @order.pending?
      @order.update_attributes(status: 1)
    elsif @order.order_confirmed?
      @order.update_attributes(status: 2)
    end
    flash[:success] = "Order status successfully updated"
    redirect_to admin_order_path(@order)
  end

  private

  def set_order
    @order ||= Order.find(params[:id])
  end
end
