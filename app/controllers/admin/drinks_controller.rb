class Admin::DrinksController < Admin::BaseController
  before_action :set_restaurant

  def index
    respond_to do |format|
      format.html
      format.json {render json: Drink.search(params[:q], fields: [{name: :word_start}], operator: "or")}
    end
  end

  def new
    @drink = Drink.new
  end

  def create
    @drink = @restaurant.drinks.new(drink_params)
    if @drink.valid?
      @drink.save
      redirect_to admin_restaurant_path(@restaurant), notice: 'Drink created successfully'
    else
      render :new
    end
  end

  private

  def drink_params
    params.require(:drink)
          .permit(:name, :default_price,
                variants_attributes: [:id, :name, :price, :restaurant_id, :_destroy])
  end

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:restaurant_id])
  end
end
