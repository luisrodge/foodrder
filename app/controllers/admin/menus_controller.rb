class Admin::MenusController < Admin::BaseController
  before_action :set_restaurant

  def new
    @menu = Menu.new
  end

  def create
    # Explicit instantiation of a new Menu object because
    # validation fails with submitted taggable_tokens param.
    # Instantiate a new Menu with the taggable_tokens param filtered out.
    @menu = Menu.new(restaurant_id: @restaurant.id, name: menu_params[:name])

    if @menu.valid?
      @menu.save!
      @menu.taggable_tokens=(menu_params[:taggable_tokens])
      redirect_to admin_restaurant_path(@restaurant),
                  notice: "Menu successfully added to restaurant"
    else
      render :new
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:name, :taggable_tokens)
  end

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:restaurant_id])
  end
end
