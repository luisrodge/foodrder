class Seller::MenusController < Seller::BaseController

  def index
    @menus = @current_restaurant.menus
  end

  def show
    @menu = Menu.find(params[:id])
    @foods = @menu.foods.order("created_at DESC")
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = @current_restaurant.menus.new(menu_params)

    if @menu.valid?
      @menu.save
      redirect_to seller_menus_path, notice: "Menu successfully created"
    else
      render :new
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:name)
  end
end
