class RestaurantsController < ApplicationController
  before_action :set_restaurant, except: :index
  before_action :set_menus, only: :show

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
    respond_to do |format|
      format.html
      format.js {render layout: false}
    end
  end

  private

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:id]).decorate
  end

  def set_menus
    @menus = @restaurant.menus.includes(foods: [:variants]).order("created_at DESC").page(params[:page]).per(3)
  end
end
