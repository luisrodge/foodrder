class Admin::DashboardsController < Admin::BaseController

  def show
    @orders = Order.pending_orders
  end
end
