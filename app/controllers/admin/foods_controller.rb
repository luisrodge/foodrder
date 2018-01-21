class Admin::FoodsController < Admin::BaseController
  before_action :set_menu, only: [:new, :create]
  before_action :set_food, only: [:edit, :update, :destroy]
  before_action :set_restaurant, except: [:destroy]

  def new
    @food = Food.new
  end

  def create
    @food = @menu.foods.new(food_params.except(:taggable_tokens))

    if @food.valid?
      @food.taggable_tokens = (food_params[:taggable_tokens])
      @food.save
      redirect_to admin_restaurant_path(@menu.restaurant),
                  notice: "Food added to menu successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @food.update_attributes(food_params)
    redirect_to admin_restaurant_path(@food.restaurant), notice: 'Food updated successfully'
  end

  def destroy
    restaurant = @food.restaurant
    @food.destroy
    redirect_to admin_restaurant_path(restaurant), notice: "Food successfully removed from menu"
  end

  private

  def set_restaurant
    @restaurant = if @menu.nil?
                    @food.restaurant
                  else
                    @menu.restaurant
                  end
  end

  def set_menu
    @menu ||= Menu.find(params[:menu_id])
  end

  def set_food
    @food ||= Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :price, :description, :primary_image,
                                 :estimated_cook_time, :taggable_tokens,
                                 variants_attributes: [:id, :name, :price, :restaurant_id, :_destroy],
                                 choices_attributes: [:id, :name, :restaurant_id, :_destroy]).merge(restaurant: @restaurant)
  end
end
