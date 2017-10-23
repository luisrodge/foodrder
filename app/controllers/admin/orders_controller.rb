class Admin::OrdersController < Admin::BaseController
  layout 'dashboard'
  before_action :authenticate_admin!

  def index
    @orders = Order.pending_orders
  end

  def show
    @order = Order.find(params[:id]).decorate
    @order_fragments = @order.order_fragments
  end
end
