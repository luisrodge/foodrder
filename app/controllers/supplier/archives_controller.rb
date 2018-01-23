class Supplier::ArchivesController < Supplier::BaseController
  before_action :set_order_fragments
  before_action :set_order_fragment, only: :show
  before_action :should_redirect, only: :show

  def index
  end

  def show
  end

  private

  def set_order_fragments
    @order_fragments = @current_restaurant.archived_order_fragments
  end

  def set_order_fragment
    @order_fragment = OrderFragment.find(params[:id])
  end

  def should_redirect
    if @order_fragment.restaurant != @current_restaurant
      redirect_to seller_dashboard_path
    end
  end

end
