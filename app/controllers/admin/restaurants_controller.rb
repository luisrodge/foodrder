class Admin::RestaurantsController < Admin::BaseController
  before_action :set_restaurant, except: [:index, :new, :create]

  def index
    @restaurants = Restaurant.order("created_at DESC")
  end

  def show
    @menus = @restaurant.menus
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.valid?
      puts "Valid"
      @restaurant.save!
      # Assign restaurant seller account
      Supplier.create!(email: restaurant_params[:origin_supplier_email],
                       password: "password", password_confirmation: "password",
                       restaurant: @restaurant)
      redirect_to admin_restaurants_path, notice: "Restaurant added successfully"
    else
      puts "invaid"
      render :new
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant.update_attributes(restaurant_params)
    redirect_to admin_restaurants_path, notice: "Restaurant updated successfully"
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone_number,
                                       :primary_image, :origin_supplier_email,
                                       :order_medium_type, :order_notify_type,
                                       :delivery, :reservation)
  end

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:id])
  end
end
