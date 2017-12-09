class Admin::MenusController < Admin::BaseController
  before_action :set_restaurant, except: [:edit, :update, :destroy]
  before_action :set_menu, only: [:edit, :update, :destroy]

  def new
    @menu = Menu.new
  end

  def create
    # Validation fails with submitted taggable_tokens param.
    # Instantiate a new Menu with the taggable_tokens param filtered out.
    @menu = @restaurant.menus.new(menu_params.except(:taggable_tokens))

    if @menu.valid?
      @menu.taggable_tokens=(menu_params[:taggable_tokens])
      @menu.save
      redirect_to admin_restaurant_path(@restaurant),
                  notice: "Menu successfully added to restaurant"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @menu.update_attributes(menu_params)
    redirect_to admin_restaurant_path(@menu.restaurant), notice: "Menu updated successfully"
  end

  def destroy
    restaurant = @menu.restaurant
    @menu.destroy
    redirect_to admin_restaurant_path(restaurant), notice: "Menu removed successfully"
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :taggable_tokens,
                                 additions_attributes: [:id, :name, :price, :_destroy])
  end

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:restaurant_id])
  end

  def set_menu
    @menu ||= Menu.find(params[:id])
  end
end
