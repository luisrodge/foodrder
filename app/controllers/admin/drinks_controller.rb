class Admin::DrinksController < Admin::BaseController
  before_action :set_restaurant

  def new
    @drink = Drink.new
  end

  def index
    respond_to do |format|
      format.html
      format.json {render json: Drink.search(params[:q], fields: [{name: :word_start}], operator: "or")}
    end
  end

  private

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:restaurant_id])
  end
end
