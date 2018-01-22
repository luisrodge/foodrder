class Supplier::FoodsController < Supplier::BaseController
  before_action :set_menu, except: [:show, :index]

  def new
    @food = Food.new
  end

  def create
    @food = @menu.foods.new(food_params)

    if @food.valid?
      @food.save
      redirect_to seller_menu_path(@menu), notice: "Food added successfully"
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
          .merge(restaurant: @current_restaurant)
  end
end
