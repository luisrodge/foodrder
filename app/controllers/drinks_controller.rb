class DrinksController < ApplicationController
  before_action :set_restaurant, only: :index
  before_action :should_redirect
  layout 'minimal'

  def index
    @drinks = @restaurant.drinks
  end

  private

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:restaurant_id])
  end

  def should_redirect
    unless @cart.restaurant_cart_fragment?(@restaurant) && @restaurant.drinks.any?
      redirect_to restaurant_path(@restaurant)
    end
  end
end
