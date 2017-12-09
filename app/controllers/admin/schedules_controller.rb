class Admin::SchedulesController < Admin::BaseController
  before_action :set_restaurant

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = @restaurant.schedules.new(schedule_params)
    if @schedule.valid?
      @schedule.save
      redirect_to root_path, notice: "Schedule saved successfully"
    else
      render :new
    end
  end

  private

  def set_restaurant
    @restaurant ||= Restaurant.find(params[:restaurant_id])
  end

  def schedule_params
    params.require(:schedule).permit(:open, :close, :recurring, :restaurant_id)
  end
end
