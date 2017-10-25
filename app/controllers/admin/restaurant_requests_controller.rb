class Admin::RestaurantRequestsController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @restaurant_requests = RestaurantRequest.pending_requests
  end

  def update
    RestaurantRequest.find(params[:id]).update_attributes(status: 1)
    redirect_to admin_restaurant_requests_path, notice: "Restaurant Request marked as reviewed"
  end
end
