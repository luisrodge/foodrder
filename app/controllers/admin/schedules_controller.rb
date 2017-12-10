class Admin::SchedulesController < Admin::BaseController
  before_action :set_schedule, only: [:edit, :update, :destroy]
  before_action :set_restaurant

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = @restaurant.build_schedule(schedule_params)
    if @schedule.valid?
      @schedule.save
      redirect_to root_path, notice: "Schedule saved successfully"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @schedule.update_attributes(schedule_params)
    redirect_to admin_restaurant_path(@restaurant), notice: "Schedule updated successfully"
  end

  private

  def set_restaurant
    @restaurant = if params[:restaurant_id].present?
                    Restaurant.find(params[:restaurant_id])
                  else
                    @schedule.restaurant
                  end

  end

  def set_schedule
    @schedule ||= Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:open, :close, :recurring, :restaurant_id,
                                     time_frames_attributes: [:id, :schedule_id, :open, :close, :_destroy])
  end
end
