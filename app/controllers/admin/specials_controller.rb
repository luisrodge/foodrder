class Admin::SpecialsController < Admin::BaseController
  before_action :set_restaurant

  def index
    @specials = @restaurant.specials.order("created_at DESC")
  end

  def new
    @special = Special.new
  end

  def create
    @special = Special.new(special_params.except(:taggable_tokens))
    if @special.valid?
      @special.taggable_tokens=(special_params[:taggable_tokens])
      @special.save
      redirect_to admin_restaurant_path(@restaurant),
                  notice: "Special '#{@special.name}' created successfully"
    else
      render :new
    end
  end

  private

  def special_params
    params.require(:special).permit(:name, :price, :description, :primary_image,
                                    :taggable_tokens, :special_date, :selling_date)
        .merge(restaurant: @restaurant)
  end

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:restaurant_id])
  end
end
