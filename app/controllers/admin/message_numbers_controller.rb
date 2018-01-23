class Admin::MessageNumbersController < Admin::BaseController
  before_action :set_message_number, only: [:edit, :update, :destroy]
  before_action :set_restaurant

  def new
    @message_number = MessageNumber.new
  end

  def create
    @message_number = @restaurant.message_numbers.new(message_number_params)
    if @message_number.valid?
      @message_number.save
      redirect_to edit_admin_restaurant_path(@restaurant), notice: "Message number created successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @message_number.update_attributes(message_number_params)
      redirect_to edit_admin_restaurant_path(@restaurant), notice: "Message number updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @message_number.destroy
    redirect_to edit_admin_restaurant_path(@restaurant), notice: "Message number removed successfully"
  end

  private

  def message_number_params
    params.require(:message_number).permit(:number, :restaurant_id)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_message_number
    @message_number = MessageNumber.find(params[:id])
  end
end
