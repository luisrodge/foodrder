class Supplier::ReservationsController < Supplier::BaseController

  def index
    @reservations = @current_restaurant.reservations.order(created_at: :desc)
  end
end
