class Admin::MenusController < Admin::BaseController
  before_action :set_restaurant

  def new
    @menu = Menu.new
  end

  def create
    @menu = @restaurant.menus.new(menu_params)

    if @menu.valid?
      @menu.menu_catgory_tokens=(menu_params[:menu_catgory_tokens])
      @menu.save
      redirect_to admin_restaurant_path(@restaurant),
                  notice: "Menu successfully added to restaurant"
    else
      render :new
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :menu_catgory_tokens)
  end

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:restaurant_id])
  end
end
