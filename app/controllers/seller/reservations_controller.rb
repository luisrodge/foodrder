class Seller::ReservationsController < ApplicationController
  before_action :authenticate_seller!
  layout 'dashboard'

  def index
    @reservations = @current_restaurant.reservations.order(created_at: :desc)
  end
end
