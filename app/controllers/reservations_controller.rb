class ReservationsController < ApplicationController
  before_action :set_restaurant
  before_action :should_redirect
  layout 'minimal'

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = @restaurant.reservations.new(reservation_params)
    if @reservation.valid?
      @reservation.save
      redirect_to root_path, notice: "Reservation request sent successfully. You'll hear back from #{@restaurant.name} restaurant soon."
    else
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:full_name, :email, :phone_number,
                                        :reserve_date, :reserve_time, :persons, :comments)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def should_redirect
    redirect_to restaurant_path(@restaurant) unless @restaurant.reservation
  end
end
