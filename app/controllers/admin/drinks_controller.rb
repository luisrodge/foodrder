class Admin::DrinksController < Admin::BaseController
  before_action :set_drink, only: [:edit, :update, :destroy]
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
      redirect_to admin_restaurant_path(@restaurant),
                  notice: 'Drink created successfully'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @drink.update_attributes(drink_params)
    redirect_to admin_restaurant_path(@restaurant), notice: 'Drink successfully updated'
  end

  def destroy
    restaurant = @drink.restaurant
    @drink.destroy
    redirect_to admin_restaurant_path(restaurant), notice: 'Drink successfully removed'
  end

  private

  def drink_params
    params.require(:drink)
        .permit(:name, :price, :primary_image,
                variants_attributes: [:id, :name, :price, :restaurant_id, :_destroy])
  end

  def set_restaurant
    @restaurant = if params[:restaurant_id].present?
                    Restaurant.find(params[:restaurant_id])
                  else
                    @drink.restaurant
                  end
  end

  def set_drink
    @drink ||= Drink.find(params[:id])
  end
end
