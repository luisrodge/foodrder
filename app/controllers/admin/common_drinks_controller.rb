class Admin::CommonDrinksController < Admin::BaseController
  before_action :set_restaurant

  def new
    @common_drink = CommonDrink.new
  end

  def create

  end

  private

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:restaurant_id])
  end
end
