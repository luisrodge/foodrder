class Admin::DashboardsController < ApplicationController
  layout 'dashboard'

  def show
    @orders = Order.pending_orders
  end
end
