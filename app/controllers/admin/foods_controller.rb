class Admin::FoodsController < Admin::BaseController
  before_action :set_menu, except: [:show, :index]

  def new
    @food = Food.new
  end

  def create
    @food = @menu.foods.new(food_params.except(:taggable_tokens))

    if @food.valid?
      @food.taggable_tokens=(food_params[:taggable_tokens])
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
                                 :estimated_cook_time, :taggable_tokens)
        .merge(restaurant: @menu.restaurant)
  end
end
