class Admin::RestaurantsController < ApplicationController
  before_action :authenticate_admin!
  def index
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
  end
end
