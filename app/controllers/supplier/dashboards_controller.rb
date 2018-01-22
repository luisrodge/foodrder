class Supplier::DashboardsController < Supplier::BaseController
  before_action :set_order_fragments

  def show
  end

  private

  def set_order_fragments
    @order_fragments = @current_restaurant.pending_order_fragments
  end
end
