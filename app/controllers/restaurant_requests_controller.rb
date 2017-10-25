class RestaurantRequestsController < ApplicationController
  def new
    @restaurant_request = RestaurantRequest.new
  end

  def create
    @restaurant_request = RestaurantRequest.new(restaurant_request_params)
    if @restaurant_request.valid?
      @restaurant_request.save
      redirect_to root_path,
                  notice: 'Thanks for your interest in foodrder, we will get
                                      back to you after reviewing your request'
    else
      render :new
    end

  end

  private

  def restaurant_request_params
    params.require(:restaurant_request).permit(:first_name, :last_name,
                                               :email, :mobile_number, :restaurant_phone_number,
                                               :location, :street_name, :number_of_employees)
  end
end
