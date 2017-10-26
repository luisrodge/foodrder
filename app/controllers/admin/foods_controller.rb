class Admin::FoodsController < Admin::BaseController
  before_action :set_menu, except: [:show, :index]

  def new
    @food = Food.new
  end

  def create
    @food = @menu.foods.new(food_params)

    if @food.valid?
      @food.save
      redirect_to admin_restaurant_path(@menu.restaurant),
                  notice: "Food added to menu successfully"
    else
      render :new
    end
  end

  private

  def set_menu
    @menu ||= Menu.find(params[:menu_id])
  end

  def food_params
    params.require(:food).permit(:name, :price, :description, :primary_image,
                                 :estimated_cook_time)
        .merge(restaurant: @menu.restaurant)
  end
end
