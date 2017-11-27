class Admin::OrderArchivesController < Admin::BaseController
  def index
    @orders = Order.processed_orders
  end
end
