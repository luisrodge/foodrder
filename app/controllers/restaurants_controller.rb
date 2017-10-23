class RestaurantsController < ApplicationController
  before_action :set_restaurant, except: :index

  def index
    @restaurants = Restaurant.order("created_at DESC")
  end

  def show
  end

  private

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:id]).decorate
  end
end
