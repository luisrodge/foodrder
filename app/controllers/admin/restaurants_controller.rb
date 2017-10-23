class Admin::RestaurantsController < Admin::BaseController
  before_action :authenticate_admin!

  def index
    @restaurants = Restaurant.all
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.valid?
      @restaurant.save
      # Assign restaurant seller account
      Seller.create(email: restaurant_params[:origin_seller_email],
                    password: "password1234", password_confirmation: "password1234",
                    restaurant: @restaurant)
      redirect_to admin_restaurants_path, notice: "Restaurant added successfully"
    else
      render :new
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :location, :street, :phone_number,
                                       :primary_image, :origin_seller_email)
  end
end
