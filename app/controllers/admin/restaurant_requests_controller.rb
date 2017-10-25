class Admin::RestaurantRequestsController < Admin::BaseController
  def index
    @restaurant_requests = RestaurantRequest.pending_requests
  end
end
