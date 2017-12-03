class RestaurantsController < ApplicationController
  before_action :set_restaurant, except: :index

  def index
    @restaurants = if params[:sort].present?
                     if params[:sort] == "delivery"
                       Restaurant.delivery_available
                     end
                   else
                     Restaurant.order("created_at DESC")
                   end
  end

  def show
  end

  private

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:id]).decorate
  end
end
