class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.pending_orders
  end

  def show
    @order = Order.find(params[:id])
  end
end
