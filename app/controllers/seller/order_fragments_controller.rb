class Seller::OrderFragmentsController < ApplicationController
  before_action :authenticate_seller!
  before_action :set_order_fragment
  before_action :should_redirect
  before_action :should_archive
  layout 'dashboard'

  def show
  end

  private

  def set_order_fragment
    @order_fragment = OrderFragment.find(params[:id])
  end

  def should_redirect
    if @order_fragment.restaurant != @current_restaurant
      redirect_to seller_dashboard_path
    end
  end

  def should_archive
    unless current_seller.have_read?(@order_fragment)
      @order_fragment.mark_as_read! for: current_seller
    end
  end
end
