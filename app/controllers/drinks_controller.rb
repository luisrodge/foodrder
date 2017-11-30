class DrinksController < ApplicationController
  before_action :set_restaurant, only: :index
  layout 'minimal'

  def index
    @drinks = @restaurant.drinks
  end

  private

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:restaurant_id])
  end
end
