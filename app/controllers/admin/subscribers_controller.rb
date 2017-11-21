class Admin::SubscribersController < Admin::BaseController
  def index
    @subscribers = Subscriber.order("created_at DESC")
  end

  def destroy
    Subscriber.find(params[:id]).destroy
    redirect_to admin_subscribers_path, notice: "Subscriber removed successfully"
  end


end
