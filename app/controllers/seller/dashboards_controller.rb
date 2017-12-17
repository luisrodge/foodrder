class Seller::DashboardsController < ApplicationController
  before_action :authenticate_seller!
  before_action :set_order_fragments
  layout 'dashboard'

  def show
  end

  private

  def set_order_fragments
    @order_fragments = @current_restaurant
                           .pending_order_fragments
                           .unread_by(current_seller)
  end
end
