class Seller::DashboardsController < ApplicationController
  before_action :authenticate_seller!
  layout 'dashboard'

  def show
    @order_fragments = @current_restaurant.pending_order_fragments
  end
end
